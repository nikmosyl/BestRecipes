//
//  HorizontalScrollSection.swift
//  BestRecipes
//
//  Created by nikita on 24.08.2025.
//

import SwiftUI

struct HorizontalScrollSection: View {
    let recipes: [Recipe] // массив элементов
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(recipes, id: \.id) { recipe in
                    RecipeItemView(recipe: recipe)
                }
            }
//            .padding(.horizontal) // отступы слева/справа
        }
    }
}

#Preview {
    HorizontalScrollSection(
        recipes: Array(repeating: Recipe.previewSample, count: 20)
    )
}
