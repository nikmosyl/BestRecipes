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
        let recipes = Fixtures.loadRecipes(named: "recipes_pasta")
        
        ScrollView {
            RecipeListView(
                recipes: recipes,
                onDelete: { _ in }
            )
            .padding()
        }
        .background(Color(.systemBackground))
        .previewDisplayName("List - fixtures (recipes_pasta)")
    }
}
#endif
