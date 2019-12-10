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
    public init(window: UIWindowType?, tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        super.init(window: window)
    }
    
    // MARK: - Coordinatorable
    override open func start(finishHandler: (() -> Void)?) {
        self.setUpChildTabBarCoordinators()
        super.start(finishHandler: finishHandler)
    }
    
    override open func finish() {
        self.tabBarController.viewControllers = []
        super.finish()
    }
}

// MARK: - Private
extension TabBarCoordinator {
    private func setUpChildTabBarCoordinators() {
        self.tabBarController.viewControllers = self.children.compactMap { ($0 as? TabBarChildCoordinatorType)?.root }
    }
}
