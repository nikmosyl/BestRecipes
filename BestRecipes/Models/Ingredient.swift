//
//  Ingredient.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import Foundation

struct Ingredient: Codable {
    let id: Int
    let name: String?
    let amount: Double?
    let imageName: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case amount = "amount"
        case imageName = "image"
    }
    
    var weight: Int {
        Int((amount ?? 0) * 28.34952)
    }
}
