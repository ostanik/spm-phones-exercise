//
//  Area.swift
//  Phones
//
//  Created by Alan Ostanik on 07/03/2021.
//

public struct Area: Parseable {
    public let codes: [String]

    public init(_ array: [String]) {
        self.codes = array.sorted()
    }
}


