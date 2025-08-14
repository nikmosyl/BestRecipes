//
//  EmptyRecipesView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 14.08.25.
//

import SwiftUI

struct EmptyRecipesView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.system(size: 60))
                .foregroundStyle(.secondary) // Современный .foregroundStyle
            
            Text("No recipes yet")
                .font(.custom("Poppins-Medium", size: 18))
                .foregroundStyle(.secondary)
            
            Text("Your created recipes will appear here")
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding()
    }
}
