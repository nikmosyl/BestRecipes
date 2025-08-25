//
//  DiscoverView.swift
//  BestRecipes
//
//  Created by nikita on 24.08.2025.
//

import SwiftUI

struct DiscoverView: View {
    @Environment(\.dismiss) private var dismiss
    
    let recipes: [Recipe]
    let title: String
    let showBackButton: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ForEach(recipes, id: \.id) { recipe in
                RecipeItemView(recipe: recipe)
                    .padding(.top, 24)
            }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            if showBackButton {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                    }
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(.custom("Poppins-SemiBold", size: 24))
            }
        }
    }
}

#Preview {
    DiscoverView(
        recipes: Array(repeating: Recipe.previewSample, count: 20),
        title: "Test title",
        showBackButton: true
    )
}
