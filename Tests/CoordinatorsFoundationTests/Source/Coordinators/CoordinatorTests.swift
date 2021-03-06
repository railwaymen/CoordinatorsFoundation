import XCTest
@testable import CoordinatorsFoundation

class CoordinatorTests: XCTestCase {
    private var coordinator: Coordinator<DeepLinkOptionMock, CoordinatorTypeMock>!
    
    override func setUp() {
        super.setUp()
        self.coordinator = self.buildCoordinator()
    }
}

// MARK: - start(on:)
extension CoordinatorTests {
    func testStart() {
        //Arrange
        let parent = self.buildCoordinator()
        let child = self.buildCoordinator()
        //Act
        child.start(on: parent)
        //Assert
        XCTAssertEqual(parent.children, [child])
        XCTAssertEqual(child.parent, parent)
    }
}

// MARK: - handleFinish()
extension CoordinatorTests {
    func testHandleFinish_removesSelfFromParent() {
        //Arrange
        let parent = self.buildCoordinator()
        let child = self.buildCoordinator()
        child.start(on: parent)
        //Act
        child.handleFinish()
        //Assert
        XCTAssert(parent.children.isEmpty)
    }
    
    func testHandleFinish_removesChildren() {
        //Arrange
        let parent = self.buildCoordinator()
        let child = self.buildCoordinator()
        child.start(on: parent)
        //Act
        parent.handleFinish()
        //Assert
        XCTAssert(parent.children.isEmpty)
    }
}

// MARK: - add(child:)
extension CoordinatorTests {
    func testAddChild_one() {
        //Arrange
        let child = self.buildCoordinator()
        self.coordinator.start(on: nil)
        //Act
        self.coordinator.add(child: child)
        //Assert
        XCTAssertEqual(self.coordinator.children.count, 1)
    }
    
    func testAddChild_two() {
        //Arrange
        let firstChild = self.buildCoordinator()
        let secondChild = self.buildCoordinator()
        self.coordinator.start(on: nil)
        //Act
        self.coordinator.add(child: firstChild)
        self.coordinator.add(child: secondChild)
        //Assert
        XCTAssertEqual(self.coordinator.children.count, 2)
    }
}

// MARK: - remove(child:)
extension CoordinatorTests {
    func testRemoveChild_withNilChildValue() {
        //Arrange
        let child = self.buildCoordinator()
        self.coordinator.start(on: nil)
        self.coordinator.add(child: child)
        //Act
        self.coordinator.remove(child: nil)
        //Assert
        XCTAssertEqual(self.coordinator.children.count, 1)
    }
    
    func testRemoveChild_withSomeChildValue() {
        //Arrange
        let child = self.buildCoordinator()
        self.coordinator.start(on: nil)
        self.coordinator.add(child: child)
        //Act
        self.coordinator.remove(child: child)
        //Assert
        XCTAssertEqual(self.coordinator.children.count, 0)
    }
    
    func testRemoveChild_whileIsAddedMoreThanOne() {
        //Arrange
        let firstChild = self.buildCoordinator()
        let secondChild = self.buildCoordinator()
        self.coordinator.start(on: nil)
        self.coordinator.add(child: firstChild)
        self.coordinator.add(child: secondChild)
        //Act
        XCTAssertEqual(self.coordinator.children.count, 2)
        self.coordinator.remove(child: firstChild)
        //Assert
        XCTAssertEqual(self.coordinator.children.count, 1)
        XCTAssertEqual(self.coordinator.children[0], secondChild)
    }
}

// MARK: - deepLinkWillBeExecuted(completion:)
extension CoordinatorTests {
    func testDeepLinkWillBeExecuted_withoutChildren() {
        //Arrange
        let factoryMock = DispatchGroupFactoryMock()
        let groupMock = DispatchGroupMock()
        factoryMock.createDispatchGroupReturnValue = groupMock
        self.coordinator = self.buildCoordinator(dispatchGroupFactory: factoryMock)
        //Act
        self.coordinator.deepLinkWillBeExecuted { XCTFail() }
        //Assert
        XCTAssertEqual(factoryMock.createDispatchGroupParams.count, 1)
        XCTAssertEqual(groupMock.enterParams.count, 0)
        XCTAssertEqual(groupMock.notifyParams.count, 1)
        XCTAssertEqual(groupMock.notifyParams.last?.queue, .main)
    }
    
    func testDeepLinkWillBeExecuted_withoutChildren_notifyCalled() {
        //Arrange
        let factoryMock = DispatchGroupFactoryMock()
        let groupMock = DispatchGroupMock()
        factoryMock.createDispatchGroupReturnValue = groupMock
        self.coordinator = self.buildCoordinator(dispatchGroupFactory: factoryMock)
        var completionCalled = false
        //Act
        self.coordinator.deepLinkWillBeExecuted {
            completionCalled = true
        }
        groupMock.notifyParams.last?.work()
        //Assert
        XCTAssertTrue(completionCalled)
        XCTAssertEqual(factoryMock.createDispatchGroupParams.count, 1)
        XCTAssertEqual(groupMock.enterParams.count, 0)
        XCTAssertEqual(groupMock.notifyParams.count, 1)
        XCTAssertEqual(groupMock.notifyParams.last?.queue, .main)
    }
    
    func testDeepLinkWillBeExecuted_twoChildren_notifyCalled() {
        //Arrange
        let factoryMock = DispatchGroupFactoryMock()
        let groupMock = DispatchGroupMock()
        factoryMock.createDispatchGroupReturnValue = groupMock
        self.coordinator = self.buildCoordinator(dispatchGroupFactory: factoryMock)
        
        let firstChild = CoordinatorMock()
        let secondChild = CoordinatorMock()
        self.coordinator.add(child: firstChild)
        self.coordinator.add(child: secondChild)
        var completionCalled = false
        //Act
        self.coordinator.deepLinkWillBeExecuted {
            completionCalled = true
        }
        groupMock.notifyParams.last?.work()
        firstChild.deepLinkWillBeExecutedParams.last?.completion()
        //Assert
        XCTAssertTrue(completionCalled)
        XCTAssertEqual(factoryMock.createDispatchGroupParams.count, 1)
        XCTAssertEqual(firstChild.deepLinkWillBeExecutedParams.count, 1)
        XCTAssertEqual(secondChild.deepLinkWillBeExecutedParams.count, 1)
        XCTAssertEqual(groupMock.enterParams.count, 2)
        XCTAssertEqual(groupMock.leaveParams.count, 1)
        XCTAssertEqual(groupMock.notifyParams.count, 1)
        XCTAssertEqual(groupMock.notifyParams.last?.queue, .main)
    }
}

// MARK: - observeDismiss(of:dismissHandler:)
extension CoordinatorTests {
    func testObserveDismiss_setsPresentationDelegate() {
        //Arrange
        let sut = self.buildCoordinator()
        let viewController = UIViewController()
        //Act
        sut.observeDismiss(of: viewController)
        //Assert
        XCTAssert(viewController.presentationController?.delegate === sut)
    }
    
    func testObserveDismiss_callsHandlerOnDismiss() throws {
        //Arrange
        let sut = self.buildCoordinator()
        let viewController = UIViewController()
        var dismissHandlerCalledCount = 0
        //Act
        sut.observeDismiss(
            of: viewController,
            didDismissHandler: {
                dismissHandlerCalledCount += 1
        })
        sut.presentationControllerDidDismiss(try XCTUnwrap(viewController.presentationController))
        //Assert
        XCTAssertEqual(dismissHandlerCalledCount, 1)
    }
    
    func testObserveDismiss_callsHandlerOnlyOnceOnDismiss() throws {
        //Arrange
        let sut = self.buildCoordinator()
        let viewController = UIViewController()
        var dismissHandlerCalledCount = 0
        //Act
        sut.observeDismiss(
            of: viewController,
            didDismissHandler: {
                dismissHandlerCalledCount += 1
        })
        sut.presentationControllerDidDismiss(try XCTUnwrap(viewController.presentationController))
        sut.presentationControllerDidDismiss(try XCTUnwrap(viewController.presentationController))
        //Assert
        XCTAssertEqual(dismissHandlerCalledCount, 1)
    }
}

// MARK: - endObserving(_:)
extension CoordinatorTests {
    func testEndObserving_setNilOnPresentationControllerDelegate() {
        //Arrange
        let sut = self.buildCoordinator()
        let viewController = UIViewController()
        sut.observeDismiss(of: viewController)
        //Act
        sut.endObserving(viewController)
        //Assert
        XCTAssertNil(try XCTUnwrap(viewController.presentationController).delegate)
    }
    
    func testEndObserving_removesDismissHandler() throws {
        //Arrange
        let sut = self.buildCoordinator()
        let viewController = UIViewController()
        var dismissHandlerCalledCount = 0
        sut.observeDismiss(
            of: viewController,
            didDismissHandler: {
                dismissHandlerCalledCount += 1
        })
        //Act
        sut.endObserving(viewController)
        sut.presentationControllerDidDismiss(try XCTUnwrap(viewController.presentationController))
        //Assert
        XCTAssertEqual(dismissHandlerCalledCount, 0)
    }
}

// MARK: - Private
extension CoordinatorTests {
    private func buildCoordinator(
        dispatchGroupFactory: DispatchGroupFactoryType? = nil
    ) -> Coordinator<DeepLinkOptionMock, CoordinatorTypeMock> {
        if let factory = dispatchGroupFactory {
            return Coordinator<DeepLinkOptionMock, CoordinatorTypeMock>(
                window: nil,
                dispatchGroupFactory: factory)
        }
        return Coordinator<DeepLinkOptionMock, CoordinatorTypeMock>()
    }
}
