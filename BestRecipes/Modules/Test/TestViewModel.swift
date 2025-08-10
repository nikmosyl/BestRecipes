//
//  TestViewModel.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import Foundation

final class TestViewModel: ObservableObject {
    @Published var counter = 0
    
    func increment() {
        counter += 1
    }
}
