//
//  Parser.swift
//  Phones
//
//  Created by Alan Ostanik on 07/03/2021.
//

import Foundation

public protocol Parseable {
    init(_ array: [String])
}

public struct Parser {
    /**
    Parse data into generic Parseable object

    @param data Valid utf8 convertible data.
    */
    public static func parse<T: Parseable>(_ data: Data) throws -> T {
        let components = try data.utf8().components().removeEmpty()
        guard !components.isEmpty else {
            throw Error.wrongFormat
        }
        return T(components)
    }
}

private extension String {
    func components() throws -> [String] {
        let components = self.components(separatedBy: "\n")
        guard !self.isEmpty else {
            throw Parser.Error.wrongFormat
        }
        return components
    }
}

private extension Array where Element == String {
    func removeEmpty() -> [String] {
        return self.filter { !$0.isEmpty }
    }
}

private extension Data {
    func utf8() throws -> String {
        guard let string = String(data: self, encoding: .utf8) else {
            throw Parser.Error.dataInvalid
        }
        return string
    }
}

public extension Parser {
    enum Error: Swift.Error, LocalizedError, Equatable {
        case wrongFormat
        case dataInvalid

        public var errorDescription: String? {
            switch self {
            case .wrongFormat:
                return NSLocalizedString("Unable to retrieve components from data", comment: "")
            case .dataInvalid:
                return NSLocalizedString("Unable to transform data into utf8", comment: "")
            }
        }
    }
}
