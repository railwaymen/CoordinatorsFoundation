import XCTest
@testable import CoordinatorsFoundation

class ArrayExtensionTests: XCTestCase {}

// MARK: - subscript(safeIndex:)
extension ArrayExtensionTests {
    func testSubscriptSafeIndex_indexNegative() {
        //Arrange
        let sut = [1]
        //Act
        let result = sut[safeIndex: -1]
        //Assert
        XCTAssertNil(result)
    }
    
    func testSubscriptSafeIndex_indexZeroWithoutElements() {
        //Arrange
        let sut: [Int] = []
        //Act
        let result = sut[safeIndex: 0]
        //Assert
        XCTAssertNil(result)
    }
    
    func testSubscriptSafeIndex_indexInRange() {
        //Arrange
        let sut = [1]
        //Act
        let result = sut[safeIndex: 0]
        //Assert
        XCTAssertEqual(result, 1)
    }
    
    func testSubscriptSafeIndex_indexGreaterThanLastIndex() {
        //Arrange
        let sut = [1]
        //Act
        let result = sut[safeIndex: 1]
        //Assert
        XCTAssertNil(result)
    }
}
