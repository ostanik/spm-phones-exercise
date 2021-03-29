import XCTest
@testable import PhonesCore

final class ProcessorTests: XCTestCase {

    lazy var area: Area = { try! Parser.parse(Manager.loadFile(path: areaCodesDirectory.path)) }()

    func testRepeatedNumber() {
        let dictionary = Processor.count(phones: ["911", "911"], areas: area.codes)
        XCTAssertEqual(dictionary, ["91":1])
    }

    func testInvalidArea() {
        let dictionary = Processor.count(phones: ["000", "991"], areas: area.codes)
        XCTAssertEqual(dictionary, [:])
    }

    func testRightCount() {
        let phones = Phone(["+351960000000","00351961111111","+351210000000","+35112","+244910000000"])
        let dictionary = Processor.count(phones: phones.numbers, areas: area.codes)
        XCTAssertEqual(dictionary, ["351":3,"244":1])
    }


    static var allTests = [
        ("testRepeatedNumber", testRepeatedNumber),
    ]
}
