//
//  DispatchGroupFactoryMock.swift
//  CoordinatorsFoundationTests
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation
@testable import CoordinatorsFoundation

class DispatchGroupFactoryMock: DispatchGroupFactoryType {
    var expectedDispatchGroup: DispatchGroupType = DispatchGroupMock()
    private(set) var createDispatchGroup_calledCount: Int = 0
    func createDispatchGroup() -> DispatchGroupType {
        self.createDispatchGroup_calledCount += 1
        return self.expectedDispatchGroup
    }
}
