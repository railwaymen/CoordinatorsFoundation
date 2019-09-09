//
//  Coordinator.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation

open class Coordinator<T: DeepLinkOptionable, U: CoordinatorTypable>: NSObject, Coordinatorable {
    public typealias CoordinatorType = U
    public typealias DeepLinkOption = T
    
    private(set) public var children: [Coordinator]
    private(set) public var window: UIWindowType?
    private var finishHandler: FinishHandlerType?
    private var dispatchGroupFactory: DispatchGroupFactoryType
    
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
    
    open func start(finishHandler: FinishHandlerType?) {
        self.finishHandler = finishHandler
    }
    
    open func finish() {
        self.children.forEach {
            $0.finish()
            self.removeChildCoordinator(child: $0)
        }
        self.finishHandler?()
    }
    
    open func addChildCoordinator(child: Coordinator) {
        self.children.append(child)
    }
    
    open func removeChildCoordinator(child: Coordinator?) {
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
}
