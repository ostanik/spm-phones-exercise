//
//  Phone.swift
//  Phones
//
//  Created by Alan Ostanik on 07/03/2021.
//

public struct Phone: Parseable {
    public let numbers: [String]

    public init(_ array: [String]) {
        self.numbers = array.compactMap { $0.parsed() }
    }
}

private extension String {
    private enum Constants {
        static let invalidePrefix = ["+ ", " ", "+0", "0 "]
        static let emptySpace = " "
        static let minLenght = 3
        static let range = 7...12
    }

    private enum AreaIdentifier: String {
        case plus = "+"
        case zero = "00"
    }

    // MARK: Rules
    var validPrefix: Bool {
        return Constants.invalidePrefix.reduce(true) { (prev, value) in
            return prev && !self.hasPrefix(value)
        }
    }

    var onlyNumbers: Bool {
        return Int(self.remove(.plus).removeSpaces()) != nil
    }

    var validLenght: Bool {
        let string = self.remove(.plus).removeSpaces()
        guard string.count != Constants.minLenght else { return true }
        return string.remove(.zero).lenght(in: Constants.range)
    }

    var valid: Bool {
        return self.validPrefix && self.onlyNumbers && self.validLenght
    }

    // MARK: Utility

    func parsed() -> String? {
        guard self.valid else { return nil }
        let string = self.remove(.plus).trimmingCharacters(in: .whitespacesAndNewlines)
        guard string.count != 3 else { return string }
        return string.remove(.zero)
    }

    private func remove(prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    private func remove(_ identifier: AreaIdentifier) -> String {
        return self.remove(prefix: identifier.rawValue)
    }

    private func removeSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }

    private func lenght(in range: ClosedRange<Int>) -> Bool {
        return self.count >= range.lowerBound && self.count <= range.upperBound
    }
}
