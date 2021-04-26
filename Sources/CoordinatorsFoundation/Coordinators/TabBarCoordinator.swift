//
//  TabBarCoordinator.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

public protocol TabBarChildCoordinatorType: class {
    var root: UIViewController { get }
    var tabBarItem: UITabBarItem { get }
}

public protocol TabBarCoordinatorType: class {
    var tabBarController: UITabBarController { get }
}

open class TabBarCoordinator<T: DeepLinkOptionable, U: CoordinatorTypable>: Coordinator<T, U>, TabBarCoordinatorType {
    open var tabBarController: UITabBarController
    
    // MARK: - Initialization
    
    ///
    /// - Parameters:
    ///   - window: Window for setting coordinator's controller as rootViewController
    ///
    public override init(window: UIWindowType? = nil) {
        self.tabBarController = UITabBarController()
        super.init(window: window)
    }
    
    ///
    /// - Parameters:
    ///   - window: Window for setting coordinator's controller as rootViewController
    ///   - tabBarController: Main controller for the coordinator
    ///
    public init(
        window: UIWindowType?,
        tabBarController: UITabBarController
    ) {
        self.tabBarController = tabBarController
        super.init(window: window)
    }
    
    // MARK: - Open
    open override func start(on parent: SomeCoordinator?) {
        self.setUpChildTabBarCoordinators()
        super.start(on: parent)
    }
    
    open override func willFinish() {
        super.willFinish()
    }
    
    open override func didFinish() {
        super.didFinish()
    }
    
    open override func handleFinish() {
        self.tabBarController.viewControllers = []
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

// MARK: - Private
extension TabBarCoordinator {
    private func setUpChildTabBarCoordinators() {
        self.tabBarController.viewControllers = self.children.compactMap { ($0 as? TabBarChildCoordinatorType)?.root }
    }
}
