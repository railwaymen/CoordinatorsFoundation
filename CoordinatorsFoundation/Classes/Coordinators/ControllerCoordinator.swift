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
    
    /// - Parameters:
    ///   - window: Window for setting coordinator's controller as rootViewController
    public override init(window: UIWindowType? = nil) {
        self.controller = UIViewController()
        super.init(window: window)
        window?.rootViewController = controller
    }
    
    /// - Parameters:
    ///   - window: Window for setting coordinator's controller as rootViewController
    ///   - controller: Main controller for the coordinator
    public init(window: UIWindowType?, controller: UIViewController) {
        self.controller = controller
        super.init(window: window)
        window?.rootViewController = controller
    }
}
