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
        ScrollView {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.recipes, id: \.id) { recipe in
                        RecipeItemView(recipe: recipe)
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
