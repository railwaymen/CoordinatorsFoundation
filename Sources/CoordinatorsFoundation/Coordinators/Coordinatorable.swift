//
//  Coordinatorable.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import UIKit

public typealias DeepLinkOptionable = Equatable

public protocol CoordinatorTypable: RawRepresentable where RawValue == String {}

public protocol ViewControllerObserverType: class {
    
    ///
    /// `DismissableNavigationController` calls this method to inform about dismiss due to dismiss gesture recognizer
    /// - Parameters:
    ///   - navigationController: UINavigationController which was dismissed with a gesture
    ///
    func viewControllerDidDismiss(_ viewController: UIViewController)
}

public protocol NavigationControllerObserverType: class {
    
    ///
    /// `DismissableNavigationController` calls this method to inform about dismiss due to dismiss gesture recognizer
    /// - Parameters:
    ///   - navigationController: UINavigationController which was dismissed with a gesture
    ///
    func navigationControllerDidDismiss(_ navigationController: UINavigationController)
}

public protocol Coordinatorable: class {
    associatedtype SomeCoordinator: Coordinatorable
    associatedtype CoordinatorType: CoordinatorTypable
    associatedtype DeepLinkOption: DeepLinkOptionable
    
    var type: CoordinatorType? { get }
    var children: [SomeCoordinator] { get }
    var window: UIWindowType? { get }
    var parent: SomeCoordinator? { get }
    
    ///
    /// Runs coordinator's main flow.
    ///
    func start(on parent: SomeCoordinator?)
    
    ///
    /// Call it if coordinator's main view controller ended his life (e.g. after view dismiss).
    /// - Note:
    /// Automatically finishes all children of the coordinator. Use it carefully.
    ///
    func handleFinish()
    
    ///
    /// Adds given coordinator as child of this coordinator.
    /// - Parameters:
    ///   - child: Coordinator to be added to children.
    ///
    func add(child: SomeCoordinator)
    
    ///
    /// Removes coordinator from children. Mostly useful after child's finish call
    /// - Parameters:
    ///   - child: Optional coordinator to be removed from children.
    ///
    func remove(child: SomeCoordinator?)
    
    ///
    /// Prepares coordinator and it's children for deep link opening.
    /// You can dismiss presented view here.
    /// - Parameters:
    ///   - completion: Called after all preparation is completed.
    ///
    func deepLinkWillBeExecuted(completion: @escaping () -> Void)
    
    ///
    /// Opens deep link depending on given option
    /// - Parameters:
    ///   - option: Equatable parameter for navigation to desired destination.
    ///
    func openDeepLink(option: DeepLinkOption)
    
    ///
    /// Observes dismiss gesture of applied on the given controller.
    /// - Parameters:
    ///   - controller: Observed controller. It sets its presentationController's delegate to observe the dismiss event.
    ///   Adding another time the same controller will replace given handler to the new one.
    ///   - dismissHandler: Called after controller did dismiss with dismiss gesture available since iOS 13
    ///
    func observeDismiss(
        of controller: UIViewController,
        dismissHandler: (() -> Void)?)
    
    ///
    /// Ends observing the given controller by setting its presentationController's
    /// delegate to nil if set to the object and removing dismiss
    /// handlers associated with the controller
    /// - Parameters:
    ///   - controller: Controller to which should not be observed anymore on dismiss gesture
    ///
    func endObserving(_ controller: UIViewController)
}

// MARK: - Extension
public extension Coordinatorable {
    var type: CoordinatorType? {
        return nil
    }
    
    ///
    /// Observes dismiss gesture of applied on the given controller finishing coordinator on dismiss.
    /// - Parameters:
    ///   - controller: Observed controller. It sets its presentationController's delegate to observe the dismiss event.
    ///   Adding another time the same controller will replace given handler to the new one.
    ///
    func observeDismiss(of controller: UIViewController) {
        self.observeDismiss(of: controller, dismissHandler: nil)
    }
}
