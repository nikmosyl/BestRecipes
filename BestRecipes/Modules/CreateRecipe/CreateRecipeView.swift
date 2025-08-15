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
            
            HStack(spacing: 16) {
                Image(systemName: "person.2.fill")
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(.white)
                    }
                
                Text("Serves")
                    .font(.system(size: 16, weight: .semibold))
                
                Spacer()
                
                Text("\(viewModel.servings ?? 0)")
                    .foregroundStyle(.gray)
                
                Button {
                    viewModel.showServesPicker.toggle()
                } label: {
                    Image(systemName: "arrow.right")
                        .foregroundStyle(.black)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.gray.opacity(0.1))
            }
            .padding()
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
            EmptyView()
        }
    }
}

#Preview {
    NavigationStack {
        CreateRecipeView()
    }
}
