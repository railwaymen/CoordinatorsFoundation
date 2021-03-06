import XCTest
@testable import CoordinatorsFoundation

class TabBarCoordinatorTests: XCTestCase {}

// MARK: - init(window:)
extension TabBarCoordinatorTests {
    func testInitWithoutController() {
        //Act
        let coordinator = self.buildCoordinator()
        //Assert
        XCTAssertNotNil(coordinator.tabBarController)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    func testInitWithoutController_withWindowRoot() {
        //Arrange
        let window = UIWindow()
        //Act
        let coordinator = self.buildCoordinator(window: window)
        //Assert
        XCTAssertTrue(coordinator.window === window)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
}

// MARK: - init(window:tabBarController:)
extension TabBarCoordinatorTests {
    func testInitWithController() {
        //Arrange
        let controller = UITabBarController()
        //Act
        let coordinator = self.buildCoordinator(controller: controller)
        //Assert
        XCTAssertNil(coordinator.window?.rootViewController)
    }
    
    func testInitWithController_withWindowRoot() {
        //Arrange
        let window = UIWindow()
        let controller = UITabBarController()
        //Act
        let coordinator = self.buildCoordinator(window: window, controller: controller)
        //Assert
        XCTAssertTrue(coordinator.window === window)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
}

// MARK: - start()
extension TabBarCoordinatorTests {
    func testStart() {
        //Arrange
        let window = UIWindow()
        let coordinator = self.buildCoordinator(window: window)
        let child = TabBarChildCoordinatorMock()
        coordinator.add(child: child)
        //Act
        coordinator.start(on: nil)
        //Assert
        XCTAssertEqual(coordinator.tabBarController.viewControllers?.count, 1)
    }
}

// MARK: - start(finishHandler:)
extension TabBarCoordinatorTests {
    func testStartWithFinishHandler() {
        //Arrange
        let window = UIWindow()
        let coordinator = self.buildCoordinator(window: window)
        let child = TabBarChildCoordinatorMock()
        coordinator.add(child: child)
        //Act
        coordinator.start(on: nil)
        //Assert
        XCTAssertEqual(coordinator.tabBarController.viewControllers?.count, 1)
    }
}

// MARK: - handleFinish()
extension TabBarCoordinatorTests {
    func testFinish() {
        //Arrange
        let window = UIWindow()
        let coordinator = self.buildCoordinator(window: window)
        let firstChild = TabBarChildCoordinatorMock()
        let secondChild = TabBarChildCoordinatorMock()
        coordinator.add(child: firstChild)
        coordinator.add(child: secondChild)
        coordinator.start(on: nil)
        //Act
        XCTAssertEqual(coordinator.tabBarController.viewControllers?.count, 2)
        coordinator.handleFinish()
        //Assert
        XCTAssertEqual(coordinator.tabBarController.children.count, 0)
        XCTAssertEqual(coordinator.tabBarController.viewControllers?.count, 0)
    }
}

// MARK: - Private
extension TabBarCoordinatorTests {
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

// MARK: - Private structures
private class TabBarChildCoordinatorMock: CoordinatorMock, TabBarChildCoordinatorType {
    var root: UIViewController
    var tabBarItem: UITabBarItem
    init(root: UIViewController = UIViewController(), tabBarItem: UITabBarItem = UITabBarItem()) {
        self.root = root
        self.tabBarItem = tabBarItem
        super.init()
    }
}
