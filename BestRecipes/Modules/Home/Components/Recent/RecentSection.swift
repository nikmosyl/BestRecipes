//
//  RecentSection.swift
//  BestRecipes
//
//  Created by nikita on 25.08.2025.
//

import SwiftUI

struct RecentSection: View {
    @State private var seeAll = false
    @State private var recipes: [Recipe] = []
    
    let title = "Recent recipe"
    
    var body: some View {
        HStack {
            Text(title)
                .font(.custom("Poppins-SemiBold", size: 20))
            
            Spacer()
            
            SeeAllButton {
                seeAll = true
            }
        }
        .padding(.top, 16)
        .onAppear {
            recipes = DataManager.shared.getRecipesFrom(.recent)
        }
        .navigationDestination(isPresented: $seeAll) {
            DiscoverView(
                recipes: recipes,
                title: title,
                showBackButton: true
            )
        }
        
        if recipes.isEmpty {
            Text("You haven't had time to see anything yet")
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(recipes, id: \.id) { recipe in
                    RecentCell(recipe: recipe)
                        .frame(width: 124, height: 190)
                }
            }
        }
    }
}

#Preview {
    RecentSection()
}
