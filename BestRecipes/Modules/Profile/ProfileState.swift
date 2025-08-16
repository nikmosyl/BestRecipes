//
//  ProfileState.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//

import UIKit

/// Состояние модуля Profile
struct ProfileState {
    var profileImage: UIImage?
    var myRecipes: [Recipe] = []
    var isLoading: Bool = false
    var showImagePicker: Bool = false
    var errorMessage: String?
    
    // Computed property
    var hasRecipes: Bool {
        !myRecipes.isEmpty
    }
    
    var recipesCountText: String {
        let count = myRecipes.count
        return count == 1 ? "1 recipe" : "\(count) recipes"
    }
}
