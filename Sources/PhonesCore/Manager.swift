//
//  Manager.swift
//  Phones
//
//  Created by Alan Ostanik on 07/03/2021.
//

import Foundation

public struct Manager {
    /**
    Load file from Path

    @param path String path of file to load
    @param fileManager File manager to use, by default uses `FileManager.default`
    @return data with loaded content.
    */
    public static func loadFile(path: String, fileManager: FileManager = FileManager.default) throws -> Data {
        guard let data = fileManager.contents(atPath: path) else {
            throw Error.fileNotFound(path)
        }
        return data
    }

    /**
    Create a new file whit string content.

    @param path String path of file to be saved
    @param content to be saved in file
    @param fileManager File manager to use, by default uses `FileManager.default`
    @return data from saved content.
    */
    static func createFile(path: String,
                           content: String,
                           fileManager: FileManager = FileManager.default) throws -> Data {
        guard let data = content.data(using: .utf8) else {
            throw Error.unableToConvertString(content)
        }
        guard fileManager.createFile(atPath: path, contents: data) else {
            throw Error.unableToCreateFile(path)
        }
        return data
    }
}

public extension Manager {
    enum Error: Swift.Error, LocalizedError, Equatable {
        case fileNotFound(_ inPath: String)
        case unableToConvertString( _ string: String)
        case unableToCreateFile(_ atPath: String)

        public var errorDescription: String? {
            switch self {
            case .fileNotFound(let path):
                let format = NSLocalizedString("Unable to load file at: '%@'",comment: "")
                return String(format: format, path)
            case .unableToConvertString(let string):
                let format = NSLocalizedString("Unable to convert string to utf8. Original String: %@", comment: "")
                return String(format: format, string)
            case .unableToCreateFile(let path):
                let format = NSLocalizedString("Unable to create file at: %@", comment: "")
                return String(format: format, path)
            }
        }
    }
}
