//
//  CuisineCell.swift
//  BestRecipes
//
//  Created by nikita on 25.08.2025.
//

import SwiftUI

struct CuisineCell: View {
    @State var seeAll = false
    @State private var isLoading = false
    @State private var recipes: [Recipe] = []
    
    let cuisine: CuisineType
    
    var body: some View {
        VStack {
            Image(cuisine.rawValue)
                .resizable()
                .scaledToFill()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .shadow(radius: 1)
            
            Text(cuisine.rawValue)
                .font(.custom("Poppins-SemiBold", size: 14))
                .padding(.horizontal, 12)
        }
        .onTapGesture {
            Task {
                isLoading = true
                let loaded = await loadRecipes()
                recipes = loaded
                isLoading = false
            }
        }
        .navigationDestination(isPresented: $seeAll) {
            DiscoverView(
                recipes: recipes,
                title: cuisine.rawValue,
                showBackButton: true
            )
        }
    }
    
    private func loadRecipes() async -> [Recipe] {
        do {
            seeAll = true
            return try await DataManager.shared.getRecipes(
                type: .cuisine,
                by: cuisine.rawValue
            )
        } catch {
            print("Ошибка загрузки рецептов: \(error)")
            return []
        }
    }
}

#Preview {
    CuisineCell(cuisine: .italian)
}
