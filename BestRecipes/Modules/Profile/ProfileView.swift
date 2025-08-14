//
//  ProfileView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//


// ProfileView.swift
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
        // Title
        Text("My profile")
            .font(.custom("Poppins-SemiBold", size: 28))
        
        VStack(alignment: .leading, spacing: 40) {
            // Profile Header
            profileHeader
            
            HStack(alignment: .top, spacing: 20) {
                Text("My Recipes")
                    .font(.custom("Poppins-SemiBold", size: 28))
                Spacer()
            }
        }
        .padding(.horizontal, 40)
        .padding(.top)
        
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                
                // My Recipes Section
                myRecipesSection
                    .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .sheet(isPresented: viewModel.showImagePicker) { // Передаем Binding напрямую
            ProfileImagePicker(image: Binding(
                get: { viewModel.profileImage },
                set: { viewModel.updateProfileImage($0) }
            ))
        }
    }
    
    private var profileHeader: some View {
        HStack(alignment: .top, spacing: 20) {
            ProfileImageView(image: viewModel.profileImage)
                .onTapGesture {
                    viewModel.showImagePicker.wrappedValue = true  // Используем Binding
                }
            
            Spacer()
        }
    }
    
    private var myRecipesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, minHeight: 200)
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

#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView(viewModel: createViewModelWithFixtures())
                .previewDisplayName("With Recipes")
            
//            ProfileView(viewModel: createEmptyViewModel())
//                .previewDisplayName("Empty State")
        }
    }
    
    private static func createViewModelWithFixtures() -> ProfileViewModel {
        let viewModel = ProfileViewModel()
        let testRecipes = Fixtures.loadRecipes(named: "recipes_pasta")
        viewModel.setTestData(recipes: testRecipes)
        return viewModel
    }
    
//    private static func createEmptyViewModel() -> ProfileViewModel {
//        let viewModel = ProfileViewModel()
//        viewModel.setTestData(recipes: [])
//        return viewModel
//    }
}
#endif
