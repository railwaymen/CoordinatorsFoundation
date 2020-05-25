import XCTest
@testable import CoordinatorsFoundation

final class FinishableTests: XCTestCase {}

// MARK: - willFinish()
extension FinishableTests {
    func testWillFinish_callsHandlerOnce() {
        //Arrange
        let sut = FinishableDefaultSpy()
        //Act
        sut.willFinish()
        //Assert
        XCTAssertEqual(sut.willFinishHandlerParams.count, 1)
        XCTAssertEqual(sut.didFinishHandlerParams.count, 0)
    }
    
    func testWillFinish_coordinator_callsHandler() {
        //Arrange
        let sut = FinishableCoordinatorSpy()
        //Act
        sut.willFinish()
        //Assert
        XCTAssertEqual(sut.willFinishHandlerParams.count, 1)
        XCTAssertEqual(sut.didFinishHandlerParams.count, 0)
        XCTAssertEqual(sut.handleFinishParams.count, 0)
    }
}

// MARK: - didFinish()
extension FinishableTests {
    func testDidFinish_callsHandlerOnce() {
        //Arrange
        let sut = FinishableDefaultSpy()
        //Act
        sut.didFinish()
        //Assert
        XCTAssertEqual(sut.willFinishHandlerParams.count, 0)
        XCTAssertEqual(sut.didFinishHandlerParams.count, 1)
    }
    
    func testDidFinish_coordinator_callsHandlerAndHandleFinish() {
        //Arrange
        let sut = FinishableCoordinatorSpy()
        //Act
        sut.didFinish()
        //Assert
        XCTAssertEqual(sut.willFinishHandlerParams.count, 0)
        XCTAssertEqual(sut.didFinishHandlerParams.count, 1)
        XCTAssertEqual(sut.handleFinishParams.count, 1)
    }
}

// MARK: - finishInstantly()
extension FinishableTests {
    func testFinishInstantly_callsBothHandlersOnce() {
        //Arrange
        let sut = FinishableDefaultSpy()
        //Act
        sut.finishInstantly()
        //Assert
        XCTAssertEqual(sut.willFinishHandlerParams.count, 1)
        XCTAssertEqual(sut.didFinishHandlerParams.count, 1)
    }
}
