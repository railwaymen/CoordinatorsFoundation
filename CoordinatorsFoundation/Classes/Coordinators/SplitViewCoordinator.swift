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
    public override init(window: UIWindowType? = nil) {
        self.splitViewController = UISplitViewController()
        self.splitViewController.viewControllers = [UIViewController(), UIViewController()]
        super.init(window: window)
        self.window?.rootViewController = self.splitViewController
    }
    
    public init(window: UIWindowType?, splitViewController: UISplitViewController) {
        self.splitViewController = splitViewController
        super.init(window: window)
        self.window?.rootViewController = self.splitViewController
    }
    
    // MARK: - CoordinatorType
    open func start(splitViewController: UISplitViewController, finishHandler: (() -> Void)?) {
        self.splitViewController = splitViewController
        self.window?.rootViewController = self.splitViewController
        super.start(finishHandler: finishHandler)
    }
}
