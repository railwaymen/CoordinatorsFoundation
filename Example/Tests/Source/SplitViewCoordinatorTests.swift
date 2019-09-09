//
//  SplitViewCoordinatorTests.swift
//  CoordinatorsFoundation_Tests
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 Railwaymen. All rights reserved.
//

import XCTest
@testable import CoordinatorsFoundation

class SplitViewCoordinatorTests: XCTestCase {
    
    func testInit_withNilWindow() {
        //Act
        let coordinator = self.buildCoordinator(window: nil)
        //Assert
        XCTAssertNotNil(coordinator.splitViewController)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    func testInit_withNotNilWindow() {
        //Arrange
        let window = UIWindow()
        //Act
        let coordinator = self.buildCoordinator(window: window)
        //Assert
        XCTAssertNotNil(coordinator.splitViewController)
        XCTAssertNotNil(coordinator.window?.rootViewController)
    }
    
    func testInitWithSplitViewController() {
        //Arrange
        let controller = UISplitViewController()
        //Act
        let coordinator = self.buildCoordinator(controller: controller)
        //Assert
        XCTAssertEqual(coordinator.splitViewController, controller)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    func testStart() {
        //Arrange
        let window = UIWindow()
        let splitViewController = UISplitViewController()
        let coordinator = self.buildCoordinator(window: window)
        //Act
        coordinator.start(splitViewController: splitViewController, finishHandler: nil)
        //Assert
        XCTAssertEqual(coordinator.splitViewController, splitViewController)
        XCTAssertEqual(coordinator.window?.rootViewController, splitViewController)
    }
    
    // MARK: - Private
    private func buildCoordinator(
        window: UIWindowType? = nil,
        controller: UISplitViewController? = nil
        ) -> SplitViewCoordinator<DeepLinkOptionMock, CoordinatorTypeMock> {
        if let controller = controller {
            return SplitViewCoordinator<DeepLinkOptionMock, CoordinatorTypeMock>(
                window: window,
                splitViewController: controller)
        }
        return SplitViewCoordinator<DeepLinkOptionMock, CoordinatorTypeMock>(window: window)
    }
}
