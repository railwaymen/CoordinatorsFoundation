//
//  NavigationCoordinator.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//

import UIKit

public protocol NavigationCoordinatorType: class {
    var navigationController: UINavigationController { get }
}

open class NavigationCoordinator<T: DeepLinkOptionable, U: CoordinatorTypable>: Coordinator<T, U>, NavigationCoordinatorType {
    public var navigationController: UINavigationController
    
    // MARK: - Initialization
    required public init(window: UIWindowType?) {
        self.navigationController = UINavigationController()
        super.init(window: window)
        window?.rootViewController = navigationController
        navigationController.interactivePopGestureRecognizer?.delegate = nil
    }
    
    public init(window: UIWindowType?, navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init(window: window)
        window?.rootViewController = navigationController
        navigationController.interactivePopGestureRecognizer?.delegate = nil
    }
}
