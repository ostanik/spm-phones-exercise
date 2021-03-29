import XCTest
@testable import PhonesCore

final class PhoneTests: XCTestCase {

    func testInvalidPlusSpace() {
        let phones = Phone(["+ 1234653"])
        XCTAssertTrue(phones.numbers.isEmpty)
    }

    func testInvalidPlusWithZero() {
        let phones = Phone(["+001234123"])
        XCTAssertTrue(phones.numbers.isEmpty)
    }

    func testInvalidInitialSpace() {
        let phones = Phone([" 001"])
        XCTAssertTrue(phones.numbers.isEmpty)
    }

    func testInvalidChar() {
        let phones = Phone(["001.123"])
        XCTAssertTrue(phones.numbers.isEmpty)
    }

    func testLenghtEqualsFour() {
        let phones = Phone(["00123", "+1234"])
        XCTAssertTrue(phones.numbers.isEmpty)
    }

    func testLenghtGreaterThanTwelvePlus() {
        let phones = Phone(["+1234567891234"])
        XCTAssertTrue(phones.numbers.isEmpty)
    }

    func testLenghtGreaterThanTwelveZero() {
        let phones = Phone(["001234567891234"])
        XCTAssertTrue(phones.numbers.isEmpty)
    }

    func testLenghtThreeCharsPlus() {
        let phones = Phone(["+123"])
        XCTAssertEqual(phones.numbers.first?.count, 3)
    }

    func testLenghtThreeCharsZero() {
        let phones = Phone(["001"])
        XCTAssertEqual(phones.numbers.first?.count, 3)
    }

    func testLenghtThreeChars() {
        let phones = Phone(["911"])
        XCTAssertEqual(phones.numbers.first?.count, 3)
    }

    func testLenghtEqualsSeven(){
        let phones = Phone(["001234567"])
        XCTAssertEqual(phones.numbers.first?.count, 7)
    }

    func testLengthEqualsTwelvePlus() {
        let phones = Phone(["+123456789123"])
        XCTAssertEqual(phones.numbers.first?.count, 12)
    }

    func testLenghtEqualsTwelveZero() {
        let phones = Phone(["00123456789123"])
        XCTAssertEqual(phones.numbers.first?.count, 12)
    }

    func testValidSpacesPlus() {
        let phone = Phone(["+1 23 000 000 000"])
        XCTAssertEqual(phone.numbers.first, "1 23 000 000 000")
    }

    func testValidSpacesZero() {
        let phone = Phone(["00351 000 000 000"])
        XCTAssertEqual(phone.numbers.first, "351 000 000 000")
    }

    static var allTests = [
        ("testInvalidPlusSpace", testInvalidPlusSpace),
        ("testInvalidPlusWithZero", testInvalidPlusWithZero),
        ("testInvalidInitialSpace", testInvalidInitialSpace),
        ("testInvalidChar", testInvalidChar),
        ("testLenghtEqualsFour", testLenghtEqualsFour),
        ("testLenghtGreaterThanTwelvePlus", testLenghtGreaterThanTwelvePlus),
        ("testLenghtGreaterThanTwelveZero", testLenghtGreaterThanTwelveZero),
        ("testLenghtThreeCharsPlus", testLenghtThreeCharsPlus),
        ("testLenghtThreeCharsZero", testLenghtThreeCharsZero),
        ("testLenghtThreeChars", testLenghtThreeChars),
        ("testLenghtEqualsSeven", testLenghtEqualsSeven),
        ("testLengthEqualsTwelvePlus", testLengthEqualsTwelvePlus),
        ("testLenghtEqualsTwelveZero", testLenghtEqualsTwelveZero),
        ("testValidSpacesPlus", testValidSpacesPlus),
        ("testValidSpacesZero", testValidSpacesZero),
    ]
}
