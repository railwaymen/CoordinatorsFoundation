//
//  DispatchGroupFactory.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Bartłomiej Świerad. All rights reserved.
//

import Foundation

protocol DispatchGroupFactoryType: class {
    func createDispatchGroup() -> DispatchGroupType
}

class DispatchGroupFactory: DispatchGroupFactoryType {
    func createDispatchGroup() -> DispatchGroupType {
        return DispatchGroup()
    }
}
