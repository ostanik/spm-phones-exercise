import XCTest
import PhonesTests

var tests = [XCTestCaseEntry]()
tests += PhonesTests.allTests()
tests += PhoneTests.allTests()
tests += ParserTests.allTests()
tests += ManagerTests.allTests()

XCTMain(tests)
