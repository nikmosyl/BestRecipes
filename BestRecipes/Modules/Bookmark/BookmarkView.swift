//
//  BookmarkView.swift
//  BestRecipes
//
//  Created by nikita on 24.08.2025.
//

import SwiftUI

struct BookmarkView: View {
    var body: some View {
        DiscoverView(
            recipes: DataManager.shared.getRecipesFrom(.favorites),
            title: "Saved recipes",
            showBackButton: false
        )
    }
}

#Preview {
    BookmarkView()
}
