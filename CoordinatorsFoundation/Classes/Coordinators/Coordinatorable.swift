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

public protocol Coordinatorable: class {
    typealias FinishHandlerType = () -> Void

    associatedtype Coordinator: Coordinatorable
    associatedtype CoordinatorType: CoordinatorTypable
    associatedtype DeepLinkOption: DeepLinkOptionable
    
    var type: CoordinatorType? { get }
    var children: [Coordinator] { get }
    var window: UIWindowType? { get }
        
    func start(finishHandler: FinishHandlerType?)
    func finish()
    func addChildCoordinator(child: Coordinator)
    func removeChildCoordinator(child: Coordinator?)
    func deepLinkWillBeExecuted(completion: @escaping () -> Void)
    func openDeepLink(option: DeepLinkOption)
}

public extension Coordinatorable {
    var type: CoordinatorType? {
        return nil
    }
    
    func start() {
        self.start(finishHandler: nil)
    }
}
