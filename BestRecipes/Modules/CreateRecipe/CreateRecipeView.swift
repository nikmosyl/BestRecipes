//
//  CreateRecipeView.swift
//  BestRecipes
//
//  Created by Иван Семикин on 12/08/2025.
//

import SwiftUI
import PhotosUI

struct CreateRecipeView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = CreateRecipeViewModel()
    
    var body: some View {
        ScrollView {
            RecipeImageView()
            
            TextField("Title", text: $viewModel.title)
                .padding(.vertical, 8)
                .padding(.horizontal)
                .overlay {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .foregroundStyle(.red)
                }
                .padding(.horizontal)
        
            ServesCountView()
            
            CookTimeView()
        }
        .environmentObject(viewModel)
        .navigationTitle("Create Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                }
            }
        }
        .sheet(isPresented: $viewModel.showServesPicker) {
            ServesPickerSheetView()
                .environmentObject(viewModel)
                .presentationDetents([.height(280)])
        }
    }
}

#Preview {
    NavigationStack {
        CreateRecipeView()
    }
}
