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
        VStack {
            ScrollView {
                VStack(spacing: 16) {
                    RecipeImageView()
                    
                    RecipeTitleView()
                    
                    ServesCountView()
                    
                    CookTimeView()
                    
                    IngredientsBlockView()
                }
            }
            .scrollIndicators(.hidden)
            
            CreateRecipeButtonView()
        }
        .padding()
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
        .sheet(isPresented: $viewModel.showCookTimePicker) {
            TimePickerSheetView()
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
