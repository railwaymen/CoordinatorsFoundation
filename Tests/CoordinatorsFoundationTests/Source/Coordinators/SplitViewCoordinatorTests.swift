import XCTest
@testable import CoordinatorsFoundation

class SplitViewCoordinatorTests: XCTestCase {}
    
// MARK: - init(window:)
extension SplitViewCoordinatorTests {
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
        XCTAssertTrue(coordinator.window === window)
        XCTAssertNil(coordinator.window?.rootViewController)
    }
}

// MARK: - init(window:splitViewController:)
extension SplitViewCoordinatorTests {
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
    }
}

// MARK: - Private
extension SplitViewCoordinatorTests {
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
