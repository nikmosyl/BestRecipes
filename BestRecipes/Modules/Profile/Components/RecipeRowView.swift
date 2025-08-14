//
//  RecipeRowView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//

import SwiftUI

// Временная реализация карточки рецепта
// TODO: Заменить на существующую, если есть
struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Image with rating and cooking time
            ZStack(alignment: .bottomTrailing) {
                // Recipe Image
                AsyncImage(url: URL(string: recipe.imageURL ?? "")) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure, .empty:
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.2))
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray.opacity(0.5))
                            )
                    @unknown default:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .frame(height: 180)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                
                // Rating overlay (top-left)
                VStack {
                    HStack {
                        // Rating View
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.ultraThinMaterial)
                                .frame(width: 65, height: 28)
                            
                            HStack(spacing: 3) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 12))
                                    .foregroundColor(.orange)
                                
                                Text(String(format: "%.1f", recipe.rating))
                                    .font(.custom("Poppins-SemiBold", size: 14))
                                    .foregroundStyle(.primary)
                            }
                        }
                        
                        Spacer()
                        
                        // BookmarkButton убран согласно дизайну Profile
                    }
                    Spacer()
                    
                    // Recipe Title
                    Text(recipe.title ?? "Unknown Recipe")
                        .font(.custom("Poppins-SemiBold", size: 16))
                        .lineLimit(2)
                        .foregroundColor(.primary)
                }
                .padding(12)
                
                // Cooking Time (bottom-right)
                if let minutes = recipe.readyInMinutes, minutes > 0 {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.ultraThinMaterial)
                            .frame(width: 56, height: 26)
                        
                        Text(formatTime(minutes: minutes))
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundStyle(.primary)
                    }
                    .padding(12)
                }
            }
            .frame(height: 180)
            
        }
        .padding(.vertical, 4)
    }
    
    private func formatTime(minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        
        if hours > 0 {
            return String(format: "%dh %02dm", hours, mins)
        } else {
            return String(format: "%d min", mins)
        }
    }
}

#if DEBUG
struct RecipeRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            RecipeRowView(recipe: Recipe(
                id: 1,
                title: "Pasta Carbonara with Bacon",
                instruction: nil,
                instructions: nil,
                author: "Italian Chef",
                spoonacularScore: 85.5,
                readyInMinutes: 30,
                imageURL: "https://img.spoonacular.com/recipes/642583-312x231.jpg",
                extendedIngredients: nil,
                dishTypes: ["main course"],
                servings: 4
            ))
            
            RecipeRowView(recipe: Recipe(
                id: 2,
                title: "Quick Salad",
                instruction: nil,
                instructions: nil,
                author: nil,
                spoonacularScore: 72.0,
                readyInMinutes: 10,
                imageURL: nil,
                extendedIngredients: nil,
                dishTypes: ["salad"],
                servings: 2
            ))
        }
        .padding()
        .background(Color(.systemBackground))
    }
}
#endif
