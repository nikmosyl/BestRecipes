//
//  HomeView.swift
//  BestRecipes
//
//  Created by nikita on 20.08.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            TrendingSection(
                recipes: Array(repeating: Recipe.previewSample, count: 20)
            )
            
            CategorySection(
                currentCategory: $viewModel.currentCategory,
                categories: MealType.allCases,
                recipes: viewModel.categoryRecipes
            )
            
            RecentSection(recipes: viewModel.recents)
            
            CuisineSection()
        }
        .padding(.horizontal, 16)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Get amazing recipes for cooking")
                    .font(.custom("Poppins-SemiBold", size: 24))
            }
        }
    }
}

#Preview {
    HomeView()
}
