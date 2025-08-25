//
//  SearchResult.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import Foundation

struct SearchResult: Decodable {
    let results: [Recipe]
    let offset: Int?
    let number:  Int?
    let totalResults: Int?
}
