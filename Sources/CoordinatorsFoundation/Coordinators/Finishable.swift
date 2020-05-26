//
//  Finishable.swift
//  CoordinatorsFoundation
//  
//
//  Created by Bartłomiej Świerad on 25/05/2020.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation

public protocol Finishable: class {
    associatedtype FinishHandlerType
    var willFinishHandler: FinishHandlerType? { get set }
    var didFinishHandler: FinishHandlerType? { get set }
    
    func willFinish()
    
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
