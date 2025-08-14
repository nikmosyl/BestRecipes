//
//  ProfileView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    
    // передаём готовый VM (для превью/DI)
    @MainActor
    init(viewModel: ProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // дефолтный init для прод-кода
    @MainActor
    init() {
        _viewModel = StateObject(wrappedValue: ProfileViewModel())
    }
    
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
                    
                    // My Recipes Section
                    myRecipesSection
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("My Profile")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $viewModel.showImagePicker) { ProfileImagePicker(image: $viewModel.profileImage)
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
                    viewModel.showImagePicker = true
                }
            
            Spacer()
        }
    }
    
    private var myRecipesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                }
                .frame(minHeight: 200)
            } else if viewModel.hasRecipes {
                // Вертикальный список рецептов
                RecipeListView(
                    recipes: viewModel.myRecipes,
                    onDelete: viewModel.deleteRecipe
                )
            } else {
                emptyStateView
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No recipes yet")
                .font(.custom("Poppins-Medium", size: 18))
                .foregroundColor(.secondary)
            
            Text("Your created recipes will appear here")
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding()
    }
}
