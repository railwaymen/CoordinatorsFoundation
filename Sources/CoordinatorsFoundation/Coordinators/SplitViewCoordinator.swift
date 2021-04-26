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
    open func start(
        splitViewController: UISplitViewController,
        on parent: SomeCoordinator?
    ) {
        self.splitViewController = splitViewController
        super.start(on: parent)
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
