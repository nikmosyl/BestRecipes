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
    let onSelect: ((Recipe) -> Void)?
    
    init(
        recipes: [Recipe],
        onDelete: @escaping (Recipe) -> Void
    ) {
        self.recipes = recipes
        self.onDelete = onDelete
        self.onSelect = nil
    }
    
    init(
        recipes: [Recipe],
        onDelete: @escaping (Recipe) -> Void,
        onSelect: @escaping (Recipe) -> Void
    ) {
        self.recipes = recipes
        self.onDelete = onDelete
        self.onSelect = onSelect
    }
    
    var body: some View {
        LazyVStack(spacing: 16) {
            ForEach(recipes, id: \.id) { recipe in
                RecipeRowView(recipe: recipe)
                    .contentShape(Rectangle()) // Делаем всю карточку кликабельной
                    .onTapGesture {
                        onSelect?(recipe) // Вызываем callback если он есть
                    }
                    .contextMenu {
                        // Контекстное меню для дополнительных действий
                         if onSelect != nil {
                             Button {
                                 onSelect?(recipe)
                             } label: {
                                 Label("View Details", systemImage: "eye")
                             }
                         }
                        
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
