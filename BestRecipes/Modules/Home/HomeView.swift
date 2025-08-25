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
            if viewModel.searchText.isEmpty {
                CustomNavigationBar(title: "Get amazing recipes for cooking")
            }
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 8) {
                    SearchFieldView(
                        searchText: $viewModel.searchText,
                        onReturn: viewModel.search,
                        closeAction: { viewModel.searchText = "" }
                    )
                    
                    if viewModel.searchText.isEmpty {
                        TrendingSection(recipes: $viewModel.trandings)
                        
                        CategorySection(
                            currentCategory: $viewModel.currentCategory,
                            recipes: $viewModel.categoryRecipes,
                            categories: viewModel.categoryes
                        )
                        
                        RecentSection()
                        
                        CuisineSection()
                    } else {
                        DiscoverView(recipes: viewModel.searchResult, title: "Search", showBackButton: false)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    HomeView()
}
