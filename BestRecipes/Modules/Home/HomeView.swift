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
        VStack {
            ScrollView(showsIndicators: false) {
                TrendingSection(
                    recipes: Array(repeating: Recipe.previewSample, count: 20)
                )
                
                CategorySection(
                    currentCategory: $viewModel.currentCategory,
                    categories: MealType.allCases,
                    recipes: viewModel.categoryRecipes
                )
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
