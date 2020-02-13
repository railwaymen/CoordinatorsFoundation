import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CoordinatorsFoundationTests.allTests),
    ]
}
#endif
