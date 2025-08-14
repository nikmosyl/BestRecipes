//
//  ProfileViewModel+Preview.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 13.08.25.
//

#if DEBUG
import UIKit

extension ProfileViewModel {
    static func preview(
        image: UIImage? = UIImage(systemName: "person.circle"),
        recipes: [Recipe] = [],
        isLoading: Bool = false
    ) -> ProfileViewModel {
        ProfileViewModel(
            previewImage: image,
            recipes: recipes,
            isLoading: isLoading
        )
    }
}
#endif
