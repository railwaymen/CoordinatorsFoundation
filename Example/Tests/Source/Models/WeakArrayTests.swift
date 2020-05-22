//
//  WeakArrayTests.swift
//  CoordinatorsFoundation_Example
//
//  Created by Bartłomiej Świerad on 10/01/2020.
//  Copyright © 2020 Railwaymen. All rights reserved.
//

import XCTest
@testable import CoordinatorsFoundation

class WeakArrayTests: XCTestCase {}

// MARK: - init()
extension WeakArrayTests {
    func testInit() {
        //Act
        let sut = WeakArray<Mock>()
        //Assert
        XCTAssertEqual(sut.count, 0)
        XCTAssertEqual(sut.elements, [])
    }
}

// MARK: - init(arrayLiteral:)
extension WeakArrayTests {
    func testInitArrayLiteral() {
        //Arrange
        let firstElement = Mock()
        let secondElement = Mock()
        let thirdElement = Mock()
        //Act
        let sut: WeakArray = [firstElement, secondElement, thirdElement]
        //Assert
        XCTAssertEqual(sut.count, 3)
    }
}

// MARK: - count
extension WeakArrayTests {
    func testCount_fullArray() {
        //Arrange
        let array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        let count = sut.count
        //Assert
        XCTAssertEqual(count, 10)
    }
    
    func testCount_deinitializedOneElement() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        array.remove(at: 2)
        let count = sut.count
        //Assert
        XCTAssertEqual(count, 9)
    }
}

// MARK: - elements
extension WeakArrayTests {
    func testElements_fullArray() {
        //Arrange
        let array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        let elements = sut.elements
        //Assert
        XCTAssertEqual(elements.count, 10)
        XCTAssertEqual(elements, array)
    }
    
    func testElements_deinitializedOneElement() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        array.remove(at: 2)
        let elements = sut.elements
        //Assert
        XCTAssertEqual(elements.count, 9)
        XCTAssertEqual(elements, array)
    }
}

// MARK: - last
extension WeakArrayTests {
    func testLast_fullArray() {
        //Arrange
        let array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        let last = sut.last
        //Assert
        XCTAssertEqual(last, try XCTUnwrap(array.last))
    }
    
    func testLast_deinitialized9LastElements() throws {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        let element = try XCTUnwrap(array.first)
        array.removeAll()
        let last = sut.last
        //Assert
        XCTAssertEqual(last, element)
    }
    
    func testLast_deinitializedAllElements() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        array.removeAll()
        let last = sut.last
        //Assert
        XCTAssertNil(last)
    }
}

// MARK: - startIndex
extension WeakArrayTests {
    func testStartIndex_fullArray() {
        //Arrange
        let array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        let startIndex = sut.startIndex
        //Assert
        XCTAssertEqual(startIndex, 0)
    }
    
    func testStartIndex_deinitializedFirstElement() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        array.removeFirst()
        let startIndex = sut.startIndex
        //Assert
        XCTAssertEqual(startIndex, 0)
    }
    
    func testStartIndex_deinitializedAllElements() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        array.removeAll()
        let startIndex = sut.startIndex
        //Assert
        XCTAssertEqual(startIndex, 0)
    }
}

// MARK: - endIndex
extension WeakArrayTests {
    func testEndIndex_fullArray() {
        //Arrange
        let array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        let endIndex = sut.endIndex
        //Assert
        XCTAssertEqual(endIndex, 10)
    }
    
    func testEndIndex_deinitializedLastElement() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        array.removeLast()
        let endIndex = sut.endIndex
        //Assert
        XCTAssertEqual(endIndex, 9)
    }
    
    func testEndIndex_deinitializedOneMiddleElement() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        array.remove(at: 2)
        let endIndex = sut.endIndex
        //Assert
        XCTAssertEqual(endIndex, 9)
    }
    
    func testEndIndex_deinitializedAllElements() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        array.removeAll()
        let endIndex = sut.endIndex
        //Assert
        XCTAssertEqual(endIndex, 0)
    }
}

// MARK: - subscript(_:)
extension WeakArrayTests {
    func testSubscript_fullArray() {
        //Arrange
        let array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        let element = sut[4]
        //Assert
        XCTAssertEqual(element, array[4])
    }
    
    func testSubscript_indexOutOfBounds() {
        //Arrange
        let array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        let element = sut[10]
        //Assert
        XCTAssertNil(element)
    }
    
    func testSubscript_deinitializedOneElement() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        array.remove(at: 2)
        let element = sut[8]
        //Assert
        XCTAssertEqual(element, array[8])
    }
}

// MARK: - index(after:)
extension WeakArrayTests {
    func testIndexAfter_fullArray() {
        //Arrange
        let array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        let index = sut.index(after: 4)
        //Assert
        XCTAssertEqual(index, 5)
    }
    
    func testIndexAfter_deinitializedNextElement() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let sut = WeakArray(array)
        //Act
        array.remove(at: 5)
        let index = sut.index(after: 4)
        //Assert
        XCTAssertEqual(index, 5)
    }
}

// MARK: - append(_:)
extension WeakArrayTests {
    func testAppend_fullArray() {
        //Arrange
        let array = (0..<10).map { _ in Mock() }
        let newElement = Mock()
        var sut = WeakArray(array)
        //Act
        sut.append(newElement)
        //Assert
        XCTAssertEqual(sut.count, 11)
        XCTAssertEqual(sut.last, newElement)
    }
    
    func testAppend_deinitializedOneElement() {
        //Arrange
        var array = (0..<10).map { _ in Mock() }
        let newElement = Mock()
        var sut = WeakArray(array)
        //Act
        array.remove(at: 2)
        sut.append(newElement)
        //Assert
        XCTAssertEqual(sut.count, 10)
        XCTAssertEqual(sut.last, newElement)
    }
}

// MARK: - Operator +
extension WeakArrayTests {
    func testAdding() {
        //Arrange
        var array1 = (0..<10).map { _ in Mock() }
        var array2 = (0..<10).map { _ in Mock() }
        let sut1 = WeakArray(array1)
        let sut2 = WeakArray(array2)
        //Act
        array1.removeLast(5)
        array2.removeFirst(3)
        let result = sut1 + sut2
        //Assert
        XCTAssertEqual(result.count, 12)
        XCTAssertEqual(result.elements, array1 + array2)
    }
}

// MARK: - Private structures
private class Mock: Equatable {
    static func == (lhs: Mock, rhs: Mock) -> Bool {
        return lhs === rhs
    }
}
