//
//  DeepLinkOptionMock.swift
//  CoordinatorsFoundationTests
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import Foundation
@testable import CoordinatorsFoundation

enum DeepLinkOptionMock: DeepLinkOptionable {
    case one, two
}

enum CoordinatorType: String, CoordinatorTypable {
    case one, two
}
