//
//  Recipe+Mock.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 13.08.25.
//

import Foundation

#if DEBUG
extension Recipe {
    static func mock(id: Int, title: String, readyInMinutes: Int) -> Recipe {
        Recipe(
            id: id,
            title: title,
            instruction: nil,
            instructions: nil,
            author: "Test Author",
            spoonacularScore: Double.random(in: 60...95),
            readyInMinutes: readyInMinutes,
            imageURL: nil,
            extendedIngredients: [],
            dishTypes: ["demo"],
            servings: 2
        )
    }
}
#endif
