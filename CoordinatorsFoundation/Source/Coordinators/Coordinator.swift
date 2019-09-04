//
//  Coordinator.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Bartłomiej Świerad. All rights reserved.
//

import Foundation

class Coordinator<T: DeepLinkOptionable, U: CoordinatorTypable>: NSObject, Coordinatorable {
    typealias CoordinatorType = U
    typealias DeepLinkOption = T
    
    private(set) var children: [Coordinator]
    private(set) var window: UIWindowType?
    private var finishHandler: FinishHandlerType?
    private var dispatchGroupFactory: DispatchGroupFactoryType
    
    required init(window: UIWindowType?) {
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
    
    func start(finishHandler: FinishHandlerType?) {
        self.finishHandler = finishHandler
    }
    
    func finish() {
        self.children.forEach {
            $0.finish()
            self.removeChildCoordinator(child: $0)
        }
        self.finishHandler?()
    }
    
    func addChildCoordinator(child: Coordinator) {
        self.children.append(child)
    }
    
    func removeChildCoordinator(child: Coordinator?) {
        guard let index = self.children.firstIndex(where: { $0 === child }) else { return }
        self.children.remove(at: index)
    }
    
    func deepLinkWillBeExecuted(completion: @escaping () -> Void) {
        let group = self.dispatchGroupFactory.createDispatchGroup()
        self.children.reversed().forEach {
            group.enter()
            $0.deepLinkWillBeExecuted { group.leave() }
        }
        group.notify(queue: .main) { completion() }
    }
    
    func openDeepLink(option: DeepLinkOption) {}
}
