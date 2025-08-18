//
//  Recipe.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import Foundation

struct Recipe: Codable {
    let id: Int
    let title: String?
    let instruction: String?
    let instructions: [Instruction]?
    let author: String?
    let spoonacularScore: Double?
    let readyInMinutes: Int?
    let imageURL: String?
    let extendedIngredients: [Ingredient]?
    let dishTypes: [String]?
    let servings: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case instruction = "instructions"
        case instructions = "analyzedInstructions"
        case author = "sourceName"
        case spoonacularScore = "spoonacularScore"
        case readyInMinutes = "readyInMinutes"
        case imageURL = "image"
        case extendedIngredients = "extendedIngredients"
        case dishTypes = "dishTypes"
        case servings = "servings"
    }
    
    var rating: Double {
        guard let spoonacularScore else { return 0.0 }
        
        return 5 * spoonacularScore / 100.0
    }
    
    let reviewsCount: Int = Int.random(in: 200...500)
}

extension Recipe {
    static let previewSample: Recipe = {
        let steps = [
            Step(number: 1, step: "Peel and dice yams."),
            Step(number: 2, step: "Boil for 15 minutes until tender."),
            Step(number: 3, step: "Mash with butter and season to taste.")
        ]
        let instruction = Instruction(steps: steps)

        let ingredients: [Ingredient] = [
            Ingredient(id: 11601, name: "yam", amount: 2.0, imageName: "sweet-potato.png"),
            Ingredient(id: 1145,  name: "butter", amount: 0.05, imageName: "butter-sliced.jpg"),
            Ingredient(id: 2047,  name: "salt", amount: 0.01, imageName: "salt.jpg")
        ]
        
        let simpleInstruction = """
                Tip: For a creamier texture, add 2 tbsp of warm milk and a pinch of nutmeg.
                Serve immediately while hot.
                """
        
        return Recipe(
            id: 665504,
            title: "Yam Cream with Ginko Nuts (Preview)",
            instruction: simpleInstruction,
            instructions: [instruction],
            author: "Preview Kitchen",
            spoonacularScore: 70.9,                 // rating = 3.5
            readyInMinutes: 45,
            imageURL: "https://img.spoonacular.com/recipes/665504-312x231.jpg",
            extendedIngredients: ingredients,
            dishTypes: ["side dish"],
            servings: 4
        )
    }()
}
