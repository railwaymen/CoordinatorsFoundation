//
//  ControllerCoordinatorTests.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import XCTest
import CoordinatorsFoundation

class ControllerCoordinatorTests: XCTestCase {
    
    func testInitWithoutController() {
        //Act
        let coordinator = self.buildCoordinator()
        //Assert
        XCTAssertNotNil(coordinator.controller)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    func testInitWithoutController_withWindowRoot() {
        //Act
        let window = UIWindow()
        let coordinator = self.buildCoordinator(window: window)
        //Assert
        XCTAssertNil(coordinator.window?.rootViewController)
        XCTAssertTrue(coordinator.window === window)
    }
    
    func testInitWithController() {
        //Arrange
        let controller = UIViewController()
        //Act
        let coordinator = self.buildCoordinator(controller: controller)
        //Assert
        XCTAssertEqual(coordinator.controller, controller)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    func testInitWithController_withWindowRoot() {
        //Arrange
        let window = UIWindow()
        let controller = UIViewController()
        //Act
        let coordinator = self.buildCoordinator(window: window, controller: controller)
        //Assert
        XCTAssertTrue(coordinator.window === window)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    // MARK: - Private
    private func buildCoordinator(
        window: UIWindowType? = nil,
        controller: UIViewController? = nil
    ) -> ControllerCoordinator<DeepLinkOptionMock, CoordinatorTypeMock> {
        if let controller = controller {
            return ControllerCoordinator<DeepLinkOptionMock, CoordinatorTypeMock>(
                window: window,
                controller: controller)
        }
        return ControllerCoordinator<DeepLinkOptionMock, CoordinatorTypeMock>(window: window)
    }
}
