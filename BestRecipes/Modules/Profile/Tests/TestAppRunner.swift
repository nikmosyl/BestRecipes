//
//  TestAppRunner.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 14.08.25.
//


//
//  TestAppRunner.swift
//  BestRecipes
//
//  Временный файл для тестирования ProfileModule
//

import SwiftUI

struct TestAppRunner: View {
    @State private var isAddingRecipe = false
    @State private var statusMessage = ""
    
    var body: some View {
        TabView {
            // Profile Tab
            ProfileModule.makeProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .tag(0)
            
            // Test Controls Tab
            testControlsView
                .tabItem {
                    Label("Test", systemImage: "hammer")
                }
                .tag(1)
        }
    }
    
    private var testControlsView: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Test Controls")
                    .font(.largeTitle)
                    .padding()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Current Status:")
                        .font(.headline)
                    Text("Recipes count: \(ProfileModule.userRecipesCount())")
                    Text("Has recipes: \(ProfileModule.hasUserRecipes() ? "Yes" : "No")")
                    if !statusMessage.isEmpty {
                        Text(statusMessage)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                VStack(spacing: 12) {
                    Button(action: addTestRecipe) {
                        Label("Add Test Recipe", systemImage: "plus.circle.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isAddingRecipe)
                    
                    Button(action: clearAllRecipes) {
                        Label("Clear All Recipes", systemImage: "trash.fill")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
                .padding(.horizontal)
                
                if isAddingRecipe {
                    ProgressView("Adding recipe...")
                        .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Test Controls")
        }
    }
    
    private func addTestRecipe() {
        isAddingRecipe = true
        statusMessage = "Fetching recipe..."
        
        Task {
            do {
                let queries = ["pasta", "pizza", "salad", "burger", "sushi"]
                let randomQuery = queries.randomElement() ?? "pasta"
                
                let recipes = try await DataManager.shared.getRecipes(
                    type: .search,
                    by: randomQuery,
                    amount: 1
                )
                
                if let recipe = recipes.first {
                    DataManager.shared.addRecipe(recipe, to: .mine)
                    await MainActor.run {
                        statusMessage = "Added: \(recipe.title ?? "Unknown")"
                        isAddingRecipe = false
                    }
                } else {
                    await MainActor.run {
                        statusMessage = "No recipe found"
                        isAddingRecipe = false
                    }
                }
            } catch {
                await MainActor.run {
                    statusMessage = "Error: \(error.localizedDescription)"
                    isAddingRecipe = false
                }
            }
        }
    }
    
    private func clearAllRecipes() {
        let recipes = DataManager.shared.getRecipesFrom(.mine)
        recipes.forEach { recipe in
            DataManager.shared.deleteRecipe(recipe, from: .mine)
        }
        statusMessage = "Cleared all \(recipes.count) recipes"
    }
}

// Использование в App:
struct BestRecipesApp_Test: App {
    var body: some Scene {
        WindowGroup {
            TestAppRunner()
        }
    }
}