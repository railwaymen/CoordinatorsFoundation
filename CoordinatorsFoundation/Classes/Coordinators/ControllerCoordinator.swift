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
    public override init(window: UIWindowType? = nil) {
        self.controller = UIViewController()
        super.init(window: window)
        window?.rootViewController = controller
    }
    
    public init(window: UIWindowType?, controller: UIViewController) {
        self.controller = controller
        super.init(window: window)
        window?.rootViewController = controller
    }
}
