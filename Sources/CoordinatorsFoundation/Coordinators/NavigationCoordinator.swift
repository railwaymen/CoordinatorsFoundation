//
//  NavigationCoordinator.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

public protocol NavigationCoordinatorType: class {
    var navigationController: UINavigationController { get }
}

open class NavigationCoordinator<T: DeepLinkOptionable, U: CoordinatorTypable>: Coordinator<T, U>, NavigationCoordinatorType {
    open var navigationController: UINavigationController
    
    // MARK: - Initialization
    
    ///
    /// Initializes coordinator observing dismiss gesture on `self.navigationController`
    /// - Parameters:
    ///   - window: Window for setting coordinator's controller as rootViewController
    ///
    public override init(window: UIWindowType? = nil) {
        let navigationController = UINavigationController()
        self.navigationController = navigationController
        super.init(window: window)
        self.observeDismiss(of: navigationController)
        navigationController.interactivePopGestureRecognizer?.delegate = nil
    }
    
    ///
    /// - Parameters:
    ///   - window: Window for setting coordinator's controller as rootViewController
    ///   - navigationController: Main controller for the coordinator
    /// - Note:
    ///   Initializer sets `navigationController` dismiss observer automatically
    ///
    public init(
        window: UIWindowType?,
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
        super.init(window: window)
        self.observeDismiss(of: navigationController)
        navigationController.interactivePopGestureRecognizer?.delegate = nil
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
