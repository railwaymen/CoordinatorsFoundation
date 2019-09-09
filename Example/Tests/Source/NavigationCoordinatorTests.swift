//
//  NavigationCoordinatorTests.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import CoordinatorsFoundation

class NavigationCoordinatorTests: XCTestCase {
    
    func testInitWithoutNavigationController_navigationControllerIsCreated() {
        //Act
        let coordinator = self.buildCoordinator()
        //Assert
        XCTAssertNotNil(coordinator.navigationController)
    }
    
    func testInitWithoutNavigationController_windowRootNil() {
        //Act
        let coordinator = self.buildCoordinator()
        //Assert
        XCTAssertNil(coordinator.window?.rootViewController)
        XCTAssertNil(coordinator.window?.rootViewController as? UINavigationController)
    }
    
    func testInitWithoutNavigationController_windowRoot() {
        //Act
        let window = UIWindow()
        let coordinator = self.buildCoordinator(window: window)
        //Assert
        XCTAssertNotNil(coordinator.window?.rootViewController)
        XCTAssertNotNil(coordinator.window?.rootViewController as? UINavigationController)
        XCTAssertNotNil(window.rootViewController as? UINavigationController)
    }
    
    func testInitWithNavigationController() {
        //Arrange
        let navigationController = UINavigationController()
        //Act
        let coordinator = self.buildCoordinator(controller: navigationController)
        //Assert
        XCTAssertEqual(coordinator.navigationController, navigationController)
    }
    
    func testInitWithNavigationController_windowRootNil() {
        //Arrange
        let navigationController = UINavigationController()
        //Act
        let coordinator = self.buildCoordinator(controller: navigationController)
        //Assert
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    func testInitWithNavigationController_windowRoot() {
        //Arrange
        let window = UIWindow()
        let navigationController = UINavigationController()
        //Act
        let coordinator = self.buildCoordinator(window: window, controller: navigationController)
        //Assert
        XCTAssertEqual(coordinator.window?.rootViewController, navigationController)
        XCTAssertEqual(window.rootViewController, navigationController)
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
