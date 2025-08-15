//
//  RecipeTitleView.swift
//  BestRecipes
//
//  Created by Иван Семикин on 15/08/2025.
//

import SwiftUI

struct RecipeTitleView: View {
    @EnvironmentObject private var viewModel: CreateRecipeViewModel
    
    var body: some View {
        TextField("Title", text: $viewModel.title)
            .autocorrectionDisabled()
            .padding(.vertical, 8)
            .padding(.horizontal)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(style: StrokeStyle(lineWidth: 1))
                    .foregroundStyle(.red)
            }
            .padding(.horizontal)
    }
}

#Preview {
    RecipeTitleView()
        .environmentObject(CreateRecipeViewModel())
}
