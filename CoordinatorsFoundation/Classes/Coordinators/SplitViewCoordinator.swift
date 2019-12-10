//
//  SplitViewCoordinator.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

public protocol SplitViewCoordinatorType: class {
    var splitViewController: UISplitViewController { get }
}

open class SplitViewCoordinator<T: DeepLinkOptionable, U: CoordinatorTypable>: Coordinator<T, U>, SplitViewCoordinatorType {
    open var splitViewController: UISplitViewController
    
    // MARK: - Initialization
    
    ///
    /// - Parameters:
    ///   - window: Window for setting coordinator's controller as rootViewController
    ///
    public override init(window: UIWindowType? = nil) {
        self.splitViewController = UISplitViewController()
        self.splitViewController.viewControllers = [UIViewController(), UIViewController()]
        super.init(window: window)
    }
    
    ///
    /// - Parameters:
    ///   - window: Window for setting coordinator's controller as rootViewController
    ///   - splitViewController: Main controller for the coordinator
    ///
    public init(
        window: UIWindowType?,
        splitViewController: UISplitViewController
    ) {
        self.splitViewController = splitViewController
        super.init(window: window)
    }
    
    // MARK: - CoordinatorType
    
    ///
    /// Runs main flow and swaps split view controller with given one
    /// - Parameters:
    ///   - splitViewController: Main controller for the coordinator
    ///   - finishHandler: Closure called on coordinator's finish
    ///
    open func start(splitViewController: UISplitViewController, finishHandler: (() -> Void)?) {
        self.splitViewController = splitViewController
        super.start(finishHandler: finishHandler)
    }
}
