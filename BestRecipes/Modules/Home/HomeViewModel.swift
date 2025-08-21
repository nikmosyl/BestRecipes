//
//  HomeViewModel.swift
//  BestRecipes
//
//  Created by nikita on 20.08.2025.
//

import Foundation

final class HomeViewModel: ObservableObject {
    var recipes: [Recipe] = Array(repeating: Recipe.previewSample, count: 10)
}
