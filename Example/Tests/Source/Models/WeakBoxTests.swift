//
//  WeakBoxTests.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 10/01/2020.
//  Copyright © 2020 Railwaymen. All rights reserved.
//

import XCTest
@testable import CoordinatorsFoundation

class WeakBoxTests: XCTestCase {}

// MARK: - init(_:)
extension WeakBoxTests {
    func testInit_setsValue() throws {
        //Arrange
        let element = Mock()
        //Act
        let sut = WeakBox(element)
        //Assert
        XCTAssertEqual(sut.value, element)
    }
}

// MARK: - value
extension WeakBoxTests {
    func testValue_weakReference() throws {
        //Arrange
        var element: Mock? = Mock()
        //Act
        let sut = WeakBox(try XCTUnwrap(element))
        element = nil
        //Assert
        XCTAssertNil(sut.value)
    }
}

// MARK: - Private structures
private class Mock: Equatable {
    static func == (lhs: Mock, rhs: Mock) -> Bool {
        return lhs === rhs
    }
}
