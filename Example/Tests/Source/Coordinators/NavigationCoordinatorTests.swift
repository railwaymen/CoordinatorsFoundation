//
//  NavigationCoordinatorTests.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import XCTest
@testable import CoordinatorsFoundation

class NavigationCoordinatorTests: XCTestCase {
    
    func testInitWithoutNavigationController_navigationControllerIsCreated() {
        //Act
        let coordinator = self.buildCoordinator()
        //Assert
        XCTAssertNotNil(coordinator.navigationController)
        XCTAssertNil(coordinator.window?.rootViewController)
        XCTAssertNil(coordinator.window?.rootViewController as? UINavigationController)
    }
    
    func testInitWithoutNavigationController_withWindowRoot() {
        //Act
        let window = UIWindow()
        let coordinator = self.buildCoordinator(window: window)
        //Assert
        XCTAssertTrue(coordinator.window === window)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    func testInitWithNavigationController() {
        //Arrange
        let navigationController = UINavigationController()
        //Act
        let coordinator = self.buildCoordinator(controller: navigationController)
        //Assert
        XCTAssertEqual(coordinator.navigationController, navigationController)
        XCTAssertNil(coordinator.window?.rootViewController)
    }

    func testInitWithNavigationController_withWindowRoot() {
        //Arrange
        let window = UIWindow()
        let navigationController = UINavigationController()
        //Act
        let coordinator = self.buildCoordinator(window: window, controller: navigationController)
        //Assert
        XCTAssertTrue(coordinator.window === window)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    // MARK: - Private
    private func buildCoordinator(
        window: UIWindowType? = nil,
        controller: UINavigationController? = nil
    ) -> NavigationCoordinator<DeepLinkOptionMock, CoordinatorTypeMock> {
        if let controller = controller {
            return NavigationCoordinator<DeepLinkOptionMock, CoordinatorTypeMock>(
                window: window,
                navigationController: controller)
        }
        return NavigationCoordinator<DeepLinkOptionMock, CoordinatorTypeMock>(window: window)
    }
}
