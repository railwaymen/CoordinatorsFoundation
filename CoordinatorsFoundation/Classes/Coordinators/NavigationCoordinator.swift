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
    public override init(window: UIWindowType? = nil) {
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
