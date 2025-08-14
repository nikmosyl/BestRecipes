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
    private let isPreview: Bool
    
    // MARK: - Private Properties
    private let storageManager = StorageManager.shared
    private var cancellables = Set<AnyCancellable>()
    
    init(isPreview: Bool = false) {
        self.isPreview = isPreview
    }
    
#if DEBUG
    // Специальный init для превью. Здесь можно писать в state,
    // т.к. мы находимся в том же файле.
    convenience init(previewImage: UIImage?, recipes: [Recipe], isLoading: Bool) {
        self.init(isPreview: true)
        self.state.profileImage = previewImage
        self.state.myRecipes = recipes
        self.state.isLoading = isLoading
    }
#endif
    
    func onAppear() {
        guard !isPreview else { return }
        load() // твой метод, который тянет из StorageManager
    }
    
    private func load() {
        // читаешь myRecipes, картинку и т.п.
    }
    
    // MARK: - Constants
    private enum Constants {
        static let profileImageKey = "userProfileImage"
        static let compressionQuality: CGFloat = 0.8
        static let loadingDelay: TimeInterval = 0.3
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
    
    var showImagePicker: Binding<Bool> {
        Binding(
            get: { self.state.showImagePicker },
            set: { self.state.showImagePicker = $0 }
        )
    }
    
    var hasRecipes: Bool {
        !state.myRecipes.isEmpty
    }
    
    var recipesCountText: String {
        let count = state.myRecipes.count
        return count == 1 ? "1 recipe" : "\(count) recipes"
    }
    
    //    // MARK: - Initialization
    //    init() {
    //        loadMyRecipes()
    //        loadProfileImage()
    //    }
    
    // MARK: - Public Methods
    func loadMyRecipes() {
        state.isLoading = true
        state.errorMessage = nil
        
        let recipes = storageManager.getRecipesFrom(.mine)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.loadingDelay) { [weak self] in
            self?.state.myRecipes = recipes
            self?.state.isLoading = false
        }
    }
    
    func deleteRecipe(_ recipe: Recipe) {
        withAnimation(.easeOut(duration: 0.2)) {
            storageManager.deleteRecipe(recipe, from: .mine)
            state.myRecipes.removeAll { $0.id == recipe.id }
        }
    }
    
    // ❌ УДАЛИЛИ showImagePicker() метод - он не нужен, есть Binding
    
    func updateProfileImage(_ image: UIImage?) {
        guard let image = image else { return }
        profileImage = image
    }
    
    // MARK: - Private Methods
    private func loadProfileImage() {
        state.profileImage = loadStoredImage()
    }
    
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
