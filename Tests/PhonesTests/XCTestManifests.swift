import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PhonesTests.allTests),
        testCase(PhoneTests.allTests),
        testCase(ParserTests.allTests),
        testCase(ManagerTests.allTests),
    ]
}
#endif
