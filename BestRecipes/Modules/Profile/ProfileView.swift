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
                        .padding(.bottom, 40)
                    
                    // My Recipes Title
                    HStack(alignment: .top, spacing: 20) {
                        Text("My recipes")
                            .font(.custom("Poppins-SemiBold", size: 24))
                        Spacer()
                    }
                    .padding(.horizontal, 40)
                    
                    myRecipesSection
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My profile")
                        .font(.custom("Poppins-SemiBold", size: 24))
                        .foregroundColor(.primary)
                }
            }
            .refreshable { // pull-to-refresh
                viewModel.loadMyRecipes()
             }
            .navigationDestination(isPresented: $showRecipeDetail) {
                // TODO: Добавить сюда RecipeDetailView когда он появится
                if let recipe = selectedRecipe {
                    // Добавить сюда:
                    // RecipeDetailModule.makeRecipeDetailView(recipe: recipe)
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
        
        // логировать пока нет детального экрана
        // print("Selected recipe: \(recipe.title ?? "Unknown")")
    }
}

// MARK: - Previews (iOS 17+ style)
#if DEBUG && swift(>=5.9)
#Preview("Profile with recipes") {
    ProfileView()
}
#endif
