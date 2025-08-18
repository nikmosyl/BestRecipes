//
//  RecipeDetailView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 16.08.25.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var viewModel: RecipeDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Initialization
    init(recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: RecipeDetailViewModel(recipe: recipe))
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                loadingView
            } else {
                recipeContent
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.primary)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Recipe detail")
                    .font(.custom("Poppins-SemiBold", size: 24))
                    .foregroundColor(.primary)
            }
        }
    }
    
    // MARK: - Loading View
    private var loadingView: some View {
        VStack(spacing: 20) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                .scaleEffect(1.5)
            
            Text("Loading recipe...")
                .font(.custom("Poppins-Regular", size: 16))
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // MARK: - Recipe Content
    private var recipeContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                recipeCardSection
                    .padding(.horizontal, 20)
                
                instructionsSection
                    .padding(.horizontal, 20)
                
                ingredientsSection
                    .padding(.horizontal, 20)
            }
            .padding(.vertical, 20)
        }
    }
    
    // MARK: - Recipe Card Section
    private var recipeCardSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Recipe title
            Text(viewModel.recipe.title ?? "Recipe")
                .font(.custom("Poppins-Bold", size: 24))
                .foregroundColor(.primary)
            
            // Recipe image
            AsyncImage(url: URL(string: viewModel.recipe.imageURL ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                case .failure, .empty:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .overlay(
                            Image(systemName: "photo")
                                .font(.system(size: 50))
                                .foregroundColor(.gray.opacity(0.5))
                        )
                        .frame(height: 200)
                @unknown default:
                    ProgressView()
                        .frame(height: 200)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            // Rating and reviews
            HStack(spacing: 16) {
                // Rating
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.orange)
                    
                    Text(String(format: "%.1f", viewModel.recipe.rating))
                        .font(.custom("Poppins-Medium", size: 14))
                        .foregroundColor(.primary)
                }
                
                // Reviews count
                Text("(\(viewModel.recipe.reviewsCount) Reviews)")
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.secondary)
                
                Spacer()
            }
        }
    }
    
    // MARK: - Instructions Section
    private var instructionsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Instructions")
                .font(.custom("Poppins-Bold", size: 20))
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 12) {
                // 1) Нумерованные шаги (analyzedInstructions)
                if let steps = viewModel.recipe.instructions?.first?.steps, !steps.isEmpty {
                    ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(index + 1).")
                                .font(.custom("Poppins-Medium", size: 16))
                                .foregroundColor(.primary)
                                .frame(width: 20, alignment: .leading)
                            
                            Text(step.step ?? "")
                                .font(.custom("Poppins-Regular", size: 14))
                                .foregroundColor(.primary)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Spacer(minLength: 0)
                        }
                    }
                }
                
                // 2) Простой текст instructions (если есть)
                if let simple = cleanedInstructionText(), !simple.isEmpty {
                    // Разделитель (необязательно)
                    if let steps = viewModel.recipe.instructions?.first?.steps, !steps.isEmpty {
                        Divider().opacity(0.25)
                    }
                    
                    Text(simple)
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(.red) // выделение красным
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                // 3) Если нет ни шагов, ни simple — заглушка
                if (viewModel.recipe.instructions?.first?.steps?.isEmpty ?? true),
                   (viewModel.recipe.instruction == nil || cleanedInstructionText()?.isEmpty == true) {
                    Text("No instructions available")
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    // MARK: - Helpers
    private func cleanedInstructionText() -> String? {
        guard let raw = viewModel.recipe.instruction?.trimmingCharacters(in: .whitespacesAndNewlines),
              !raw.isEmpty
        else { return nil }
        
        // Удаляем HTML, если приезжает
        let plain = stripHTML(from: raw)
        
        return plain
    }
    
    // MARK: - Ingredients Section
    private var ingredientsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Ingredients")
                    .font(.custom("Poppins-Bold", size: 20))
                    .foregroundColor(.primary)
                
                Spacer()
                
                if let count = viewModel.recipe.extendedIngredients?.count {
                    Text("\(count) items")
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(.secondary)
                }
            }
            
            VStack(spacing: 12) {
                if let ingredients = viewModel.recipe.extendedIngredients {
                    ForEach(ingredients, id: \.id) { ingredient in
                        IngredientCard(ingredient: ingredient)
                    }
                } else {
                    Text("No ingredients available")
                        .font(.custom("Poppins-Regular", size: 14))
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 20)
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    private func stripHTML(from string: String) -> String {
        string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

// MARK: - Previews
#Preview {
    NavigationStack {
        RecipeDetailView(recipe: .previewSample)
    }
}
