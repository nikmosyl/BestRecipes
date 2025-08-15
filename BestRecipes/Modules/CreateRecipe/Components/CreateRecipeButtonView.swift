//
//  CreateRecipeButtonView.swift
//  BestRecipes
//
//  Created by Иван Семикин on 15/08/2025.
//

import SwiftUI

struct CreateRecipeButtonView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var viewModel: CreateRecipeViewModel
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Create Recipe")
                .fontWeight(.semibold)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
                .foregroundStyle(.white)
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.red)
                }
        }
    }
}

#Preview {
    CreateRecipeButtonView()
        .environmentObject(CreateRecipeViewModel())
}
