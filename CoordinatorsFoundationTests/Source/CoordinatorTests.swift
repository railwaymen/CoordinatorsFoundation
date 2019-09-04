//
//  CoordinatorTests.swift
//  CoordinatorsFoundation
//
//  Created by Bartłomiej Świerad on 04/09/2019.
//  Copyright © 2019 Bartłomiej Świerad. All rights reserved.
//

import XCTest
@testable import CoordinatorsFoundation

class CoordinatorTests: XCTestCase {
    private var coordinator: Coordinator<DeepLinkOptionMock, CoordinatorTypeMock>!
    
    override func setUp() {
        super.setUp()
        self.coordinator = self.buildCoordinator()
    }
    
    func testFinish() {
        //Arrange
        let child = self.buildCoordinator()
        var childFinished = false
        child.start {
            childFinished = true
        }
        var finishCalled = false
        self.coordinator.start {
            finishCalled = true
        }
        self.coordinator.addChildCoordinator(child: child)
        //Act
        self.coordinator.finish()
        //Assert
        XCTAssertTrue(finishCalled)
        XCTAssertTrue(childFinished)
        XCTAssertEqual(self.coordinator.children.count, 0)
    }
    
    func testAddChildCoordinator_one() {
        //Arrange
        let child = self.buildCoordinator()
        self.coordinator.start()
        //Act
        self.coordinator.addChildCoordinator(child: child)
        //Assert
        XCTAssertEqual(self.coordinator.children.count, 1)
    }
    
    func testAddChildCoordinators_two() {
        //Arrange
        let firstChild = self.buildCoordinator()
        let secondChild = self.buildCoordinator()
        self.coordinator.start()
        //Act
        self.coordinator.addChildCoordinator(child: firstChild)
        self.coordinator.addChildCoordinator(child: secondChild)
        //Assert
        XCTAssertEqual(self.coordinator.children.count, 2)
    }
    
    func testRemoveChildCoordinator_withNilChildValue() {
        //Arrange
        let child = self.buildCoordinator()
        self.coordinator.start()
        self.coordinator.addChildCoordinator(child: child)
        //Act
        self.coordinator.removeChildCoordinator(child: nil)
        //Assert
        XCTAssertEqual(self.coordinator.children.count, 1)
    }
    
    func testRemoveChildCoordinator_withSomeChildValue() {
        //Arrange
        let child = self.buildCoordinator()
        self.coordinator.start()
        self.coordinator.addChildCoordinator(child: child)
        //Act
        self.coordinator.removeChildCoordinator(child: child)
        //Assert
        XCTAssertEqual(self.coordinator.children.count, 0)
    }
    
    func testRemoveChildCoordinator_whileIsAddedMoreThanOne() {
        //Arrange
        let firstChild = self.buildCoordinator()
        let secondChild = self.buildCoordinator()
        self.coordinator.start()
        self.coordinator.addChildCoordinator(child: firstChild)
        self.coordinator.addChildCoordinator(child: secondChild)
        //Act
        XCTAssertEqual(self.coordinator.children.count, 2)
        self.coordinator.removeChildCoordinator(child: firstChild)
        //Assert
        XCTAssertEqual(self.coordinator.children.count, 1)
        XCTAssertEqual(self.coordinator.children[0], secondChild)
    }
    
    func testDeepLinkWillBeExecuted_withoutChildren() {
        //Arrange
        let factoryMock = DispatchGroupFactoryMock()
        let groupMock = DispatchGroupMock()
        factoryMock.expectedDispatchGroup = groupMock
        self.coordinator = self.buildCoordinator(dispatchGroupFactory: factoryMock)
        //Act
        self.coordinator.deepLinkWillBeExecuted { XCTFail() }
        //Assert
        XCTAssertEqual(factoryMock.createDispatchGroup_calledCount, 1)
        XCTAssertEqual(groupMock.enter_calledCount, 0)
        XCTAssertEqual(groupMock.notify_calledCount, 1)
        XCTAssertEqual(groupMock.notify_queue, .main)
    }
    
    func testDeepLinkWillBeExecuted_withoutChildren_notifyCalled() {
        //Arrange
        let factoryMock = DispatchGroupFactoryMock()
        let groupMock = DispatchGroupMock()
        factoryMock.expectedDispatchGroup = groupMock
        self.coordinator = self.buildCoordinator(dispatchGroupFactory: factoryMock)
        var completionCalled = false
        //Act
        self.coordinator.deepLinkWillBeExecuted {
            completionCalled = true
        }
        groupMock.notify_work?()
        //Assert
        XCTAssertTrue(completionCalled)
        XCTAssertEqual(factoryMock.createDispatchGroup_calledCount, 1)
        XCTAssertEqual(groupMock.enter_calledCount, 0)
        XCTAssertEqual(groupMock.notify_calledCount, 1)
        XCTAssertEqual(groupMock.notify_queue, .main)
    }
    
    func testDeepLinkWillBeExecuted_twoChildren_notifyCalled() {
        //Arrange
        let factoryMock = DispatchGroupFactoryMock()
        let groupMock = DispatchGroupMock()
        factoryMock.expectedDispatchGroup = groupMock
        self.coordinator = self.buildCoordinator(dispatchGroupFactory: factoryMock)
        
        let firstChild = CoordinatorMock()
        let secondChild = CoordinatorMock()
        self.coordinator.addChildCoordinator(child: firstChild)
        self.coordinator.addChildCoordinator(child: secondChild)
        var completionCalled = false
        //Act
        self.coordinator.deepLinkWillBeExecuted {
            completionCalled = true
        }
        groupMock.notify_work?()
        firstChild.deepLinkWillBeExecuted_completion?()
        //Assert
        XCTAssertTrue(completionCalled)
        XCTAssertEqual(factoryMock.createDispatchGroup_calledCount, 1)
        XCTAssertEqual(firstChild.deepLinkWillBeExecuted_calledCount, 1)
        XCTAssertEqual(secondChild.deepLinkWillBeExecuted_calledCount, 1)
        XCTAssertEqual(groupMock.enter_calledCount, 2)
        XCTAssertEqual(groupMock.leave_calledCount, 1)
        XCTAssertEqual(groupMock.notify_calledCount, 1)
        XCTAssertEqual(groupMock.notify_queue, .main)
    }
    
    // MARK: - Private
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
