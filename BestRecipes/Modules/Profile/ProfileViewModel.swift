//
//  ProfileViewModel.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//

import SwiftUI
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published private(set) var state = ProfileState()
    
    // MARK: - Private Properties
    private let dataManager = DataManager.shared
    private var cancellables = Set<AnyCancellable>()
    private var hasLoadedInitially = false
    
    // MARK: - Constants
    private enum Constants {
        static let profileImageKey = "userProfileImage"
        static let compressionQuality: CGFloat = 0.8
        static let loadingDelay: TimeInterval = 0.3
    }
    
    // MARK: - Initialization
    init() {
        // Загружаем только изображение профиля
        state.profileImage = loadStoredImage()
        // Рецепты загрузятся через onAppear
    }
    
    // MARK: - Computed Properties
    var profileImage: UIImage? {
        get { state.profileImage ?? loadStoredImage() }
        set {
            state.profileImage = newValue
            saveImageToStorage(newValue)
        }
    }
    
    var myRecipes: [Recipe] {
        state.myRecipes
    }
    
    var isLoading: Bool {
        state.isLoading
    }
    
    @Published var showImagePicker = false
    
    var hasRecipes: Bool {
        !state.myRecipes.isEmpty
    }
    
    var recipesCountText: String {
        let count = state.myRecipes.count
        return count == 1 ? "1 recipe" : "\(count) recipes"
    }
    
    // MARK: - Public Methods
    func loadMyRecipes() {
        // Избегаем множественных одновременных загрузок
        guard !state.isLoading else { return }
        
        state.isLoading = true
        state.errorMessage = nil
        
        // Используем DataManager вместо StorageManager
        let recipes = dataManager.getRecipesFrom(.mine)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.loadingDelay) { [weak self] in
            self?.state.myRecipes = recipes
            self?.state.isLoading = false
            self?.hasLoadedInitially = true
        }
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        withAnimation(.easeOut(duration: 0.2)) {
            dataManager.deleteRecipe(recipe, from: .mine)
            state.myRecipes.removeAll { $0.id == recipe.id }
        }
    }
    
    func addRecipe(_ recipe: Recipe) {
        dataManager.addRecipe(recipe, to: .mine)
        loadMyRecipes()
    }
    
    func updateProfileImage(_ image: UIImage?) {
        guard let image = image else { return }
        profileImage = image
    }
    
    // MARK: - Private Methods
    
    private func loadStoredImage() -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: Constants.profileImageKey),
              let image = UIImage(data: data) else {
            return nil
        }
        return image
    }
    
    private func saveImageToStorage(_ image: UIImage?) {
        guard let image = image,
              let data = image.jpegData(compressionQuality: Constants.compressionQuality) else {
            UserDefaults.standard.removeObject(forKey: Constants.profileImageKey)
            return
        }
        UserDefaults.standard.set(data, forKey: Constants.profileImageKey)
    }
}

// Usecase:
// ...
// Интеграция в TabBar
//
//
// .tabItem {
//    Label("Profile", systemImage: "person.circle")
// }
// .tag(ProfileIndex)

// Usage:
// ...
// ProfileModule.makeProfileView()
