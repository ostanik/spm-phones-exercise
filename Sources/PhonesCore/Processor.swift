//
//  Precessor.swift
//  Phones
//
//  Created by Alan Ostanik on 07/03/2021.
//

import Foundation

public struct Processor {

    /**
    Counts phone numbers with area codes

    @param phones Array of valid phones
    @param areas Array of valid area codes
    @return Dictionary with area code as keys and phone count as values
    */
    public static func count(phones: [String], areas: [String]) -> [String: Int] {
        let possibleAreas = areas.possibleValues(from: phones).sorted()
        var possiblePhones = Array(Set(phones.possibleValues(from: areas))).sorted()
        var dictionary = [String: Int]()
        for area in possibleAreas {
            if possiblePhones.count == 0 { return dictionary }
            let count = possiblePhones.reduce(0) { (prev, val) in
                if val.hasPrefix(area) {
                    possiblePhones.removeAll { $0 == val }
                    return prev + 1
                }
                return prev
            }
            guard count != 0 else { continue }
            dictionary[area] = count
        }
        return dictionary
    }
}

private extension Array where Element == String {
    func possibleValues(from array: [String]) -> [String] {
        let dictionary = Dictionary(grouping: self) { $0.first }
        return Dictionary(grouping: array) { $0.first }
            .filter { dictionary[$0.key] != nil}
            .compactMap { dictionary[$0.key] }
            .reduce([], +)
    }
}
