//
//  TabBarCoordinatorTests.swift
//  CoordinatorsFoundation_Tests
//
//  Created by Bartłomiej Świerad on 09/09/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import CoordinatorsFoundation

class TabBarCoordinatorTests: XCTestCase {
    
    func testInitWithoutController() {
        //Act
        let coordinator = self.buildCoordinator()
        //Assert
        XCTAssertNotNil(coordinator.tabBarController)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    func testInitWithController() {
        //Arrange
        let controller = UITabBarController()
        //Act
        let coordinator = self.buildCoordinator(controller: controller)
        //Assert
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    func testInitWithoutController_withWindowRoot() {
        //Arrange
        let window = UIWindow()
        //Act
        let coordinator = self.buildCoordinator(window: window)
        //Assert
        XCTAssertNotNil(coordinator.window?.rootViewController as? UITabBarController)
        XCTAssertNotNil(window.rootViewController as? UITabBarController)
    }
    
    func testInitWithController_withWindowRoot() {
        //Arrange
        let window = UIWindow()
        let controller = UITabBarController()
        //Act
        let coordinator = self.buildCoordinator(window: window, controller: controller)
        //Assert
        XCTAssertEqual(coordinator.window?.rootViewController, controller)
        XCTAssertEqual(window.rootViewController, controller)
    }
    
    func testStart() {
        //Arrange
        let window = UIWindow()
        let coordinator = self.buildCoordinator(window: window)
        let child = TabBarChildCoordinatorMock()
        coordinator.addChildCoordinator(child: child)
        //Act
        coordinator.start()
        //Assert
        XCTAssertEqual(coordinator.tabBarController.viewControllers?.count, 1)
    }
    
    func testStartWithFinishCompletion() {
        //Arrange
        let window = UIWindow()
        let coordinator = self.buildCoordinator(window: window)
        let child = TabBarChildCoordinatorMock()
        coordinator.addChildCoordinator(child: child)
        //Act
        coordinator.start { Void() }
        //Assert
        XCTAssertEqual(coordinator.tabBarController.viewControllers?.count, 1)
    }
    
    func testFinish() {
        //Arrange
        let window = UIWindow()
        let coordinator = self.buildCoordinator(window: window)
        let firstChild = TabBarChildCoordinatorMock()
        let secondChild = TabBarChildCoordinatorMock()
        coordinator.addChildCoordinator(child: firstChild)
        coordinator.addChildCoordinator(child: secondChild)
        coordinator.start { Void() }
        //Act
        XCTAssertEqual(coordinator.tabBarController.viewControllers?.count, 2)
        coordinator.finish()
        //Assert
        XCTAssertEqual(coordinator.tabBarController.children.count, 0)
        XCTAssertEqual(coordinator.tabBarController.viewControllers?.count, 0)
    }
    
    // MARK: - Private
    private func buildCoordinator(
        window: UIWindowType? = nil,
        controller: UITabBarController? = nil
        ) -> TabBarCoordinator<DeepLinkOptionMock, CoordinatorTypeMock> {
        if let controller = controller {
            return TabBarCoordinator<DeepLinkOptionMock, CoordinatorTypeMock>(
                window: window,
                tabBarController: controller)
        }
        return TabBarCoordinator<DeepLinkOptionMock, CoordinatorTypeMock>(window: window)
    }
}

private class TabBarChildCoordinatorMock: Coordinator<DeepLinkOptionMock, CoordinatorTypeMock>, TabBarChildCoordinatorType {
    var root: UIViewController
    var tabBarItem: UITabBarItem
    init(root: UIViewController = UIViewController(), tabBarItem: UITabBarItem = UITabBarItem()) {
        self.root = root
        self.tabBarItem = tabBarItem
        super.init(window: nil)
    }
    
    required init(window: UIWindowType?) {
        fatalError("init(window:) has not been implemented")
    }
}
