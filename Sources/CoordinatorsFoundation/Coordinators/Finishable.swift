//
//  Finishable.swift
//  CoordinatorsFoundation
//  
//
//  Created by Bartłomiej Świerad on 25/05/2020.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation

public protocol Finishable {
    associatedtype FinishHandlerType
    var willFinishHandler: FinishHandlerType? { get set }
    var didFinishHandler: FinishHandlerType? { get set }
    
    /// Should be called just before the related view would begin to dismiss
    func willFinish()
    
    /// Should be called just after the related view would dismiss
    func didFinish()
}

public extension Finishable {
    
    /// It should be called if the object finishing doesn't take any time.
    ///
    /// Calls both `willFinish` and `didFinish` one after another.
    ///
    func finishInstantly() {
        self.willFinish()
        self.didFinish()
    }
}

public extension Finishable where FinishHandlerType == (() -> Void) {
    func willFinish() {
        self.willFinishHandler?()
    }
    
    func didFinish() {
        self.didFinishHandler?()
    }
}

public extension Finishable where Self: Coordinatorable, FinishHandlerType == (() -> Void) {
    func didFinish() {
        self.handleFinish()
        self.didFinishHandler?()
    }
}
