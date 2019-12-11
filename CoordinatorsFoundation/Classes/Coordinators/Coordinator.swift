//
//  Coordinator.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

open class Coordinator<T: DeepLinkOptionable, U: CoordinatorTypable>: NSObject, Coordinatorable, UIAdaptivePresentationControllerDelegate {
    public typealias CoordinatorType = U
    public typealias DeepLinkOption = T
    
    open var type: CoordinatorType? {
        return nil
    }
    
    private(set) public var children: [Coordinator]
    private(set) public var window: UIWindowType?
    private var finishHandler: FinishHandlerType?
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
    
    // MARK: - Coordinatorable
    open func start(finishHandler: FinishHandlerType?) {
        self.finishHandler = finishHandler
    }
    
    open func finish() {
        self.children.forEach {
            $0.finish()
            self.remove(child: $0)
        }
        self.finishHandler?()
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
    
    public func observeDismiss(of controller: UIViewController, dismissHandler: (() -> Void)?) {
        controller.presentationController?.delegate = self
        let controllerHandler = ControllerHandler(
            controller: controller,
            dismissHandler: dismissHandler ?? { [weak self] in
                self?.finish()
            })
        self.observedControllersHandlers.update(with: controllerHandler)
    }
    
    public func endObserving(_ controller: UIViewController) {
        if controller.presentationController?.delegate === self {
            controller.presentationController?.delegate = nil
        }
        self.observedControllersHandlers = self.observedControllersHandlers.filter { $0.controller != controller }
    }
    
    // MARK: - UIAdaptivePresentationControllerDelegate
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.observedControllersHandlers.first { $0.controller == presentationController.presentedViewController }?.dismissHandler()
    }
}
