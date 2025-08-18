//
//  DataManager+ingredientImageUrl.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 16.08.25.
//

import Foundation

extension DataManager {
    func ingredientImageURL(for name: String) -> URL? {
        let path = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !path.isEmpty else { return nil }
        return URL(string: Link.image.rawValue + path)
    }
}
