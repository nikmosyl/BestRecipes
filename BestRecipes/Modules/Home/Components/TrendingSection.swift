//
//  HorizontalScrollSection.swift
//  BestRecipes
//
//  Created by nikita on 24.08.2025.
//

import SwiftUI

struct TrendingSection: View {
    @State var seeAll = false
    
    @Binding var recipes: [Recipe]
    
    var body: some View {
        HStack {
            Text("Trending now")
                .font(.custom("Poppins-SemiBold", size: 20))
            
            Spacer()
            
            SeeAllButton {
                seeAll = true
            }
        }
        .padding(.top, 16)
        .navigationDestination(isPresented: $seeAll) {
            DiscoverView(
                recipes: recipes,
                title: "Trending now",
                showBackButton: true
            )
        }
        if recipes.isEmpty {
            ProgressView()
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
