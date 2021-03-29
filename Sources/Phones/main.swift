import ArgumentParser
import PhonesCore
import Foundation

struct Main: ParsableCommand {
    @Argument(help: "File that contains phone numbers to validate")
    var phoneNumbers: String

    func run() {
        do {
            let path = try areaCodes().path
            let area = try Parser.parse(Manager.loadFile(path: path)) as Area
            let phone = try Parser.parse(Manager.loadFile(path: phoneNumbers)) as Phone
            Processor
                .count(phones: phone.numbers, areas: area.codes)
                .sorted { $0.0 < $1.0 }
                .forEach { print("\($0.key):\($0.value)") }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

extension Main {
    enum Error: Swift.Error {
        case fileNotFound

        public var errorDescription: String? {
            switch self {
            case .fileNotFound:
                return NSLocalizedString("Unable to load area codes file.", comment: "")
            }
        }
    }

    private func areaCodes() throws -> URL {
        guard let url = Bundle.module.url(forResource: "area_codes", withExtension: "txt") else {
            throw Error.fileNotFound
        }
        return url
    }
}

Main.main()