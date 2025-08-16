//
//  RecipeDetailPlaceholder.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 16.08.25.
//

import SwiftUI

// MARK: - Temporary Placeholder

/// Временный placeholder для экрана деталей рецепта
/// Замените на настоящий RecipeDetailView когда он будет готов

struct RecipeDetailPlaceholder: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(recipe.title ?? "Recipe Details")
                    .font(.largeTitle)
                    .padding(.horizontal)
                
                if let imageURL = recipe.imageURL {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.2))
                            .frame(height: 250)
                    }
                }
                
                Text("Recipe details will be here")
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
