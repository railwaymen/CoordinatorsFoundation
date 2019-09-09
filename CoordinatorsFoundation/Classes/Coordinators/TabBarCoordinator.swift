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
    public override init(window: UIWindowType? = nil) {
        self.tabBarController = UITabBarController()
        super.init(window: window)
        window?.rootViewController = tabBarController
    }
    
    public init(window: UIWindowType?, tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        super.init(window: window)
        window?.rootViewController = tabBarController
    }
    
    // MARK: - Coordinatorable
    open func start() {
        self.setUpChildTabBarCoordinators()
        super.start()
    }
    
    override open func start(finishHandler: (() -> Void)?) {
        self.setUpChildTabBarCoordinators()
        super.start(finishHandler: finishHandler)
    }
    
    override open func finish() {
        self.tabBarController.viewControllers = []
        super.finish()
    }
    
    // MARK: - Private
    private func setUpChildTabBarCoordinators() {
        self.tabBarController.viewControllers = self.children.compactMap { ($0 as? TabBarChildCoordinatorType)?.root }
    }
}
