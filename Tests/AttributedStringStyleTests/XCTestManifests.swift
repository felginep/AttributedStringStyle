import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AttributedStringStylerTests.allTests),
        testCase(AttributedStringBuilderTests.allTests)
    ]
}
#endif
