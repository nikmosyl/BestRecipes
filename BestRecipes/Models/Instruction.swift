//
//  Instruction.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import Foundation

struct Instruction: Codable {
    let steps: [Step]?
}

struct Step: Codable {
    let number: Int?
    let step: String?
}
