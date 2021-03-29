import XCTest
@testable import PhonesCore

final class ParserTests: XCTestCase {

    func testParseArea() {
        let areaFile = "1\n2\n3".data(using: .utf8)!
        XCTAssertNoThrow(try Parser.parse(areaFile) as Area)
    }

    func testParsePhone() {
        let phoneFile = "1\n2\n3".data(using: .utf8)!
        XCTAssertNoThrow(try Parser.parse(phoneFile) as Phone)
    }

    func testParseEmptyEOF() throws {
        let areaFile = "1\n2\n3\n".data(using: .utf8)!
        let area = try Parser.parse(areaFile) as Area
        XCTAssertEqual(area.codes.count, 3)
        XCTAssertEqual(area.codes, ["1","2","3"])
    }

    func testEmptyFile() {
        let file = "".data(using: .utf8)!
       XCTAssertThrowsError(try Parser.parse(file) as Phone) {
            XCTAssertTrue($0 is Parser.Error)
            XCTAssertEqual($0 as? Parser.Error, .wrongFormat)
        }
    }

    static var allTests = [
        ("testParseEmptyEOF", testParseEmptyEOF),
        ("testParseArea", testParseArea),
        ("testParsePhone", testParsePhone),
        ("testEmptyFile", testEmptyFile),
    ]
}
