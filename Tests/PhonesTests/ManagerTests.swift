import XCTest
@testable import PhonesCore

final class ManagerTests: XCTestCase {

    func testLoadFile() throws {
        let path = areaCodesDirectory.path
        XCTAssertNoThrow(try Manager.loadFile(path: path), "Unable to load file at path: \(path)")
    }

    func testLoadFileNotFound() {
        XCTAssertThrowsError(try Manager.loadFile(path: "")) {
            XCTAssertTrue($0 is Manager.Error)
            XCTAssertEqual($0 as? Manager.Error, .fileNotFound(""))
        }
    }

    func testSaveFile()  throws {
        let path = productsDirectory.path.appending("/phone_number.txt")
        XCTAssertNoThrow(try Manager.createFile(path: path, content: ""), "Unable to create file at path: \(path)")
    }

    func testSaveFileInvalidPath() {
        let path = "weirdpath:\\temp\\./user\\fir/st.csv"
        XCTAssertThrowsError(try Manager.createFile(path: path, content: "")) {
            XCTAssertTrue($0 is Manager.Error)
            XCTAssertEqual($0 as? Manager.Error, .unableToCreateFile(path))
        }
    }

    static var allTests = [
        ("testLoadFile", testLoadFile),
        ("testLoadFileNotFound", testLoadFileNotFound),
        ("testSaveFile", testSaveFile),
        ("testSaveFileInvalidPath", testSaveFileInvalidPath)
    ]
}
