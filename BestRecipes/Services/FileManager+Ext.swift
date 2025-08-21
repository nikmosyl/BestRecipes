//
//  FileManager+Ext.swift
//  BestRecipes
//
//  Created by nikita on 21.08.2025.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    static func save<T: Encodable>(_ object: T, as fileName: String) {
        let url = documentsDirectory.appendingPathComponent(fileName)
        if let data = try? JSONEncoder().encode(object) {
            try? data.write(to: url)
        }
    }

    static func load<T: Decodable>(_ type: T.Type, from fileName: String) -> T? {
        let url = documentsDirectory.appendingPathComponent(fileName)
        if let data = try? Data(contentsOf: url) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }
}
