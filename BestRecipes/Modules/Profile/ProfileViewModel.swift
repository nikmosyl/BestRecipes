//
//  ProfileViewModel.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 17.08.25.
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
    }
    
    // MARK: - Initialization
    init() {
        // Загружаем только изображение профиля
        state.profileImage = loadStoredImage()
        setupImageObserver()
    }
    
    // MARK: - Computed Properties
    var profileImage: UIImage? {
        get { state.profileImage }
        set {
            state.profileImage = newValue
            if let image = newValue {
                saveImageToStorage(image)
            }
        }
    }
    
    var myRecipes: [Recipe] { state.myRecipes }
    var isLoading: Bool { state.isLoading }
    var hasRecipes: Bool { state.hasRecipes }
    var recipesCountText: String { state.recipesCountText }
    var errorMessage: String? { state.errorMessage }
    
    var showImagePicker: Binding<Bool> {
        Binding(
            get: { self.state.showImagePicker },
            set: { self.state.showImagePicker = $0 }
        )
    }
    
    // MARK: - Public Methods
    func loadMyRecipes() {
        guard !state.isLoading else { return }
        
        state.isLoading = true
        defer { state.isLoading = false }
        
        let recipes = dataManager.getRecipesFrom(.mine)
        state.myRecipes = recipes
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
        profileImage = image
    }
    
    // MARK: - Private Methods
    private func setupImageObserver() {
        // Можно наблюдать за изменениями если нужно
        $state
            .map(\.profileImage)
            .removeDuplicates { $0 == $1 } // Сравнение UIImage может быть проблемой
            .sink { [weak self] image in
                if let image = image {
                    self?.saveImageToStorage(image)
                }
            }
            .store(in: &cancellables)
    }
    
    private func loadStoredImage() -> UIImage? {
        UserDefaults.standard.profileImageData.flatMap(UIImage.init)
    }
    
    private func saveImageToStorage(_ image: UIImage) {
        guard let data = image.jpegData(compressionQuality: Constants.compressionQuality) else {
            UserDefaults.standard.profileImageData = nil
            return
        }
        UserDefaults.standard.profileImageData = data
    }
}

extension UserDefaults {
    private enum Keys {
        static let profileImage = "userProfileImage"
    }
    
    var profileImageData: Data? {
        get { data(forKey: Keys.profileImage) }
        set {
            if let newValue = newValue {
                set(newValue, forKey: Keys.profileImage)
            } else {
                removeObject(forKey: Keys.profileImage)
            }
        }
    }
}
