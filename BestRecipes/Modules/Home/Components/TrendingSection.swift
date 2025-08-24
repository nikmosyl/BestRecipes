//
//  HorizontalScrollSection.swift
//  BestRecipes
//
//  Created by nikita on 24.08.2025.
//

import SwiftUI

struct TrendingSection: View {
    @State var seeAll = false
    
    let recipes: [Recipe]
    
    var body: some View {
        HStack {
            Text("Trending now")
                .font(.custom("Poppins-SemiBold", size: 20))
            
            Spacer()
            
            SeeAllButton {
                seeAll = true
                print("Tranding see all")
            }
        }
        .navigationDestination(isPresented: $seeAll) {
            DiscoverView(
                recipes: recipes,
                title: "Trending now",
                showBackButton: true
            )
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(recipes, id: \.id) { recipe in
                    RecipeItemView(recipe: recipe)
                }
            }
        }
    }
}

#Preview {
    TrendingSection(
        recipes: Array(repeating: Recipe.previewSample, count: 20)
    )
}
