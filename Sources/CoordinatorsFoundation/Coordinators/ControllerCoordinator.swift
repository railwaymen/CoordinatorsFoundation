//
//  ControllerCoordinator.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

public protocol ControllerCoordinatorType: class {
    var controller: UIViewController { get }
}

open class ControllerCoordinator<T: DeepLinkOptionable, U: CoordinatorTypable>: Coordinator<T, U>, ControllerCoordinatorType {
    open var controller: UIViewController
    
    // MARK: - Initialization
    
    ///
    /// Initializes coordinator observing dismiss gesture on `self.controller`
    /// - Parameters:
    ///   - window: Window for setting coordinator's controller as rootViewController
    ///
    public override init(window: UIWindowType? = nil) {
        let controller = UIViewController()
        self.controller = controller
        super.init(window: window)
        self.observeDismiss(of: controller)
    }
    
    ///
    /// - Parameters:
    ///   - window: Window for setting coordinator's controller as rootViewController
    ///   - controller: Main controller for the coordinator
    /// - Note:
    ///   Initializer sets `controller` dismiss observer automatically
    ///
    public init(
        window: UIWindowType?,
        controller: UIViewController
    ) {
        self.controller = controller
        super.init(window: window)
        self.observeDismiss(of: controller)
    }
    
    // MARK: - Open
    open override func start(on parent: Coordinator<T, U>?) {
        super.start(on: parent)
    }
    
    open override func willFinish() {
        super.willFinish()
    }
    
    open override func didFinish() {
        super.didFinish()
    }
    
    open override func handleFinish() {
        super.handleFinish()
    }
    
    open override func add(child: Coordinator<T, U>) {
        super.add(child: child)
    }
    
    open override func remove(child: Coordinator<T, U>?) {
        super.remove(child: child)
    }
    
    open override func deepLinkWillBeExecuted(completion: @escaping () -> Void) {
        super.deepLinkWillBeExecuted(completion: completion)
    }
    
    open override func openDeepLink(option: T) {
        super.openDeepLink(option: option)
    }
}
