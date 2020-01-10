//
//  WeakBox.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 10/01/2020.
//  Copyright © 2020 Railwaymen. All rights reserved.
//

import Foundation

final class WeakBox<A: AnyObject> {
    weak var value: A?
    
    init(_ value: A) {
        self.value = value
    }
}
