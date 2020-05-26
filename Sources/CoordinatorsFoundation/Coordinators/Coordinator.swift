//
//  Coordinator.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

internal protocol ControllerDismissObserver {
    func controllerWillDismiss(_ controller: UIViewController)
    func controllerDidDismiss(_ controller: UIViewController)
}

open class Coordinator<T, U>: NSObject, Coordinatorable, UIAdaptivePresentationControllerDelegate
where T: DeepLinkOptionable, U: CoordinatorTypable {
    
    public typealias SomeCoordinator = Coordinator<T, U>
    public typealias CoordinatorType = U
    public typealias DeepLinkOption = T
    
    open var type: CoordinatorType? {
        return nil
    }
    
    private(set) public var children: [Coordinator]
    private(set) public var window: UIWindowType?
    private(set) public weak var parent: Coordinator?
    
    internal var previousControllerDelegates: [UIViewController: WeakArray<Coordinator>] = [:]
    
    private var dispatchGroupFactory: DispatchGroupFactoryType
    private var observedControllersHandlers: Set<ControllerHandler> = []
    
    // MARK: - Initialization
    public init(window: UIWindowType? = nil) {
        self.children = []
        self.window = window
        self.dispatchGroupFactory = DispatchGroupFactory()
    }
    
    internal init(
        window: UIWindowType?,
        dispatchGroupFactory: DispatchGroupFactoryType
    ) {
        self.children = []
        self.window = window
        self.dispatchGroupFactory = dispatchGroupFactory
    }
    
    deinit {
        self.observedControllersHandlers.forEach { self.endObserving($0.controller) }
    }
    
    // MARK: - Coordinatorable
    open func start(on parent: Coordinator?) {
        parent?.add(child: self)
        self.parent = parent
    }
    
    open func willFinish() {}
    
    open func didFinish() {
        self.handleFinish()
    }
    
    open func handleFinish() {
        self.children.forEach {
            $0.handleFinish()
            self.remove(child: $0)
        }
        self.observedControllersHandlers.forEach { self.endObserving($0.controller) }
        self.parent?.remove(child: self)
    }
    
    open func add(child: Coordinator) {
        self.children.append(child)
    }
    
    open func remove(child: Coordinator?) {
        guard let index = self.children.firstIndex(where: { $0 === child }) else { return }
        self.children.remove(at: index)
    }
    
    open func deepLinkWillBeExecuted(completion: @escaping () -> Void) {
        let group = self.dispatchGroupFactory.createDispatchGroup()
        self.children.reversed().forEach {
            group.enter()
            $0.deepLinkWillBeExecuted { group.leave() }
        }
        group.notify(queue: .main) { completion() }
    }
    
    open func openDeepLink(option: DeepLinkOption) {}
    
    public func observeDismiss(of controller: UIViewController, didDismissHandler: (() -> Void)?) {
        if let previousDelegate = controller.presentationController?.delegate as? Coordinator {
            let previousControllerDelegates = previousDelegate.previousControllerDelegates[controller] ?? []
            self.previousControllerDelegates[controller] = previousControllerDelegates + [previousDelegate]
        }
        controller.presentationController?.delegate = self
        let controllerHandler = ControllerHandler(
            controller: controller,
            willDismissHandler: { [weak self] in
                self?.willFinish()
            },
            didDismissHandler: { [weak self] in
                didDismissHandler?()
                self?.didFinish()
            })
        self.observedControllersHandlers.update(with: controllerHandler)
    }
    
    public func endObserving(_ controller: UIViewController) {
        if controller.presentationController?.delegate === self {
            controller.presentationController?.delegate = self.previousControllerDelegates[controller]?.last
        }
        self.observedControllersHandlers = self.observedControllersHandlers.filter { $0.controller != controller }
    }
    
    // MARK: - UIAdaptivePresentationControllerDelegate
    public func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
        self.controllerWillDismiss(presentationController.presentedViewController)
    }
    
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.controllerDidDismiss(presentationController.presentedViewController)
    }
}

// MARK: - ControllerDismissObserver
extension Coordinator: ControllerDismissObserver {
    internal func controllerWillDismiss(_ controller: UIViewController) {
        self.observedControllersHandlers.first { $0.controller === controller }?.willDismissHandler()
        self.previousControllerDelegates[controller]?.prune()
        self.previousControllerDelegates[controller]?.last?.controllerWillDismiss(controller)
    }
    
    internal func controllerDidDismiss(_ controller: UIViewController) {
        self.observedControllersHandlers.first { $0.controller === controller }?.didDismissHandler()
        self.previousControllerDelegates[controller]?.prune()
        self.previousControllerDelegates[controller]?.last?.controllerDidDismiss(controller)
    }
}
