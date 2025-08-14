//
//  RecipeListView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//

import SwiftUI

struct RecipeListView: View {
    let recipes: [Recipe]
    let onDelete: (Recipe) -> Void
    
    var body: some View {
        LazyVStack(spacing: 16) {
            ForEach(recipes, id: \.id) { recipe in
                RecipeRowView(recipe: recipe)
                    .contextMenu {
                        Button(role: .destructive) {
                            withAnimation {
                                onDelete(recipe)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
    }
}

// Альтернативный вариант с List (если нужен swipe-to-delete)
struct RecipeListViewAlternative: View {
    let recipes: [Recipe]
    let onDelete: (Recipe) -> Void
    
    var body: some View {
        List {
            ForEach(recipes, id: \.id) { recipe in
                RecipeRowView(recipe: recipe)
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }
            .onDelete { indexSet in
                indexSet.map { recipes[$0] }.forEach(onDelete)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

#if DEBUG
struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            RecipeListView(
                recipes: [
                    Recipe(
                        id: 1,
                        title: "Pasta Carbonara",
                        instruction: nil,
                        instructions: nil,
                        author: "Italian Chef",
                        spoonacularScore: 85.5,
                        readyInMinutes: 30,
                        imageURL: "https://img.spoonacular.com/recipes/642583-312x231.jpg",
                        extendedIngredients: nil,
                        dishTypes: ["main course"],
                        servings: 4
                    ),
                    Recipe(
                        id: 2,
                        title: "Greek Salad",
                        instruction: nil,
                        instructions: nil,
                        author: "Mediterranean Kitchen",
                        spoonacularScore: 92.0,
                        readyInMinutes: 15,
                        imageURL: nil,
                        extendedIngredients: nil,
                        dishTypes: ["salad"],
                        servings: 2
                    ),
                    Recipe(
                        id: 3,
                        title: "Tomato Soup",
                        instruction: nil,
                        instructions: nil,
                        author: nil,
                        spoonacularScore: 78.0,
                        readyInMinutes: 45,
                        imageURL: nil,
                        extendedIngredients: nil,
                        dishTypes: ["soup"],
                        servings: 6
                    )
                ],
                onDelete: { _ in }
            )
            .padding()
        }
        .background(Color(.systemBackground))
    }
}
#endif
