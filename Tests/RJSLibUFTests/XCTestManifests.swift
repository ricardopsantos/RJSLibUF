import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(RJSLibUFTests.allTests)
    ]
}
#endif
