//
//  ControllerHandlerTests.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 10/12/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import XCTest
@testable import CoordinatorsFoundation

class ControllerHandlerTests: XCTestCase {
    
    // MARK: - Equatable
    func testEquatable_sameValues() {
        //Arrange
        let viewController = UIViewController()
        let dismissHandler: () -> Void = {}
        let sut1 = ControllerHandler(controller: viewController, dismissHandler: dismissHandler)
        let sut2 = ControllerHandler(controller: viewController, dismissHandler: dismissHandler)
        //Assert
        XCTAssertEqual(sut1, sut2)
    }
    
    func testEquatable_differentHandlers() {
        //Arrange
        let viewController = UIViewController()
        let sut1 = ControllerHandler(controller: viewController, dismissHandler: {})
        let sut2 = ControllerHandler(controller: viewController, dismissHandler: {})
        //Assert
        XCTAssertEqual(sut1, sut2)
    }
    
    func testEquatable_differentControllers() {
        //Arrange
        let dismissHandler: () -> Void = {}
        let sut1 = ControllerHandler(controller: UIViewController(), dismissHandler: dismissHandler)
        let sut2 = ControllerHandler(controller: UIViewController(), dismissHandler: dismissHandler)
        //Assert
        XCTAssertNotEqual(sut1, sut2)
    }
    
    // MARK: - Hashable
    func testHashable_sameValues() {
        //Arrange
        let viewController = UIViewController()
        let dismissHandler: () -> Void = {}
        let sut1 = ControllerHandler(controller: viewController, dismissHandler: dismissHandler)
        let sut2 = ControllerHandler(controller: viewController, dismissHandler: dismissHandler)
        let array = [sut1, sut2]
        //Act
        let set = Set(array)
        //Assert
        XCTAssertEqual(set.count, 1)
    }
    
    func testHashable_differentHandlers() {
        //Arrange
        let viewController = UIViewController()
        let sut1 = ControllerHandler(controller: viewController, dismissHandler: {})
        let sut2 = ControllerHandler(controller: viewController, dismissHandler: {})
        let array = [sut1, sut2]
        //Act
        let set = Set(array)
        //Assert
        XCTAssertEqual(set.count, 1)
    }
    
    func testHashable_differentControllers() {
        //Arrange
        let dismissHandler: () -> Void = {}
        let sut1 = ControllerHandler(controller: UIViewController(), dismissHandler: dismissHandler)
        let sut2 = ControllerHandler(controller: UIViewController(), dismissHandler: dismissHandler)
        let array = [sut1, sut2]
        //Act
        let set = Set(array)
        //Assert
        XCTAssertEqual(set.count, 2)
    }
}
