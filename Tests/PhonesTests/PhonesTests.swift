import XCTest
import class Foundation.Bundle
@testable import PhonesCore

final class PhonesTests: XCTestCase {

    func testApp() throws {
        guard #available(macOS 10.13, *) else {
            return
        }

        let fooBinary = productsDirectory.appendingPathComponent("Phones")

        let process = Process()
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe

        process.arguments = [phoneNumbersDirectory.path]

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let string = String(data: data, encoding: .utf8)
        let expected = "1:1\n351:1\n91:1\n"
        XCTAssertEqual(string, expected)
    }

    static var allTests = [
        ("testExample", testApp),
    ]
}

extension XCTestCase {

    enum Error: Swift.Error {
        case fileNotFound
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    // Returns path to the area_codes.txt file
    var areaCodesDirectory: URL {
        return try! resource(name: "area_codes", extension: "txt")
    }

    // Returns path to the phone_number.txt file
    var phoneNumbersDirectory: URL {
        return try! resource(name: "phone_numbers", extension: "txt")
    }

    private func resource(name: String, extension ext: String) throws -> URL {
        guard let url = Bundle.module.url(forResource: name, withExtension: ext) else {
            throw Error.fileNotFound
        }
        return url
    }
}
