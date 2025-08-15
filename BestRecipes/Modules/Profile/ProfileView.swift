//
//  ProfileView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var selectedRecipe: Recipe? // Для навигации
    @State private var showRecipeDetail = false // Флаг показа деталей
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    // Profile Header
                    profileHeader
                        .padding(.horizontal, 40)
                        .padding(.top, 20)
                    
                    // My Recipes Title
                    HStack(alignment: .top, spacing: 20) {
                        Text("My Recipes")
                            .font(.custom("Poppins-SemiBold", size: 28))
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    
                    myRecipesSection
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.automatic)
            .refreshable { // pull-to-refresh
                viewModel.loadMyRecipes()
             }
            .navigationDestination(isPresented: $showRecipeDetail) {
                // TODO: Добавить сюда RecipeDetailView когда он появится
                if let recipe = selectedRecipe {
                    RecipeDetailPlaceholder(recipe: recipe)
                }
            }
        }
        .sheet(isPresented: viewModel.showImagePicker) {
            ProfileImagePicker(image: Binding(
                            get: { viewModel.profileImage },
                            set: { viewModel.updateProfileImage($0) }
                        ))
        }
        .onAppear {
            // Обновляем данные при появлении экрана (при переключении между вкладками в TabView)
            viewModel.loadMyRecipes()
        }
    }
    
    private var profileHeader: some View {
        HStack(alignment: .top, spacing: 20) {
            ProfileImageView(image: viewModel.profileImage)
                .onTapGesture {
                    viewModel.showImagePicker.wrappedValue = true
                }
                .accessibilityLabel("Profile photo")
                .accessibilityHint("Tap to change photo")
            
            Spacer()
        }
    }
    
    private var myRecipesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.isLoading {
                LoadingView()
            } else if viewModel.hasRecipes {
                RecipeListView(
                    recipes: viewModel.myRecipes,
                    onDelete: viewModel.deleteRecipe,
                    onSelect: handleRecipeSelection
                )
            } else {
                EmptyRecipesView()
            }
        }
    }
    
    // MARK: - Navigation
    
    private func handleRecipeSelection(_ recipe: Recipe) {
        selectedRecipe = recipe
        showRecipeDetail = true
        
        // Альтернативный вариант - можно просто логировать пока нет детального экрана
        // print("Selected recipe: \(recipe.title ?? "Unknown")")
    }
}

// MARK: - Temporary Placeholder

/// Временный placeholder для экрана деталей рецепта
/// Замените на настоящий RecipeDetailView когда он будет готов
private struct RecipeDetailPlaceholder: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(recipe.title ?? "Recipe Details")
                    .font(.largeTitle)
                    .padding(.horizontal)
                
                if let imageURL = recipe.imageURL {
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.2))
                            .frame(height: 250)
                    }
                }
                
                Text("Recipe details will be here")
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle("Recipe Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Previews (iOS 17+ style)
#if DEBUG && swift(>=5.9)
#Preview("Profile with recipes") {
    ProfileView()
}
#endif
