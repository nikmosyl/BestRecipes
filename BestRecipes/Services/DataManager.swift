//
//  DataManager.swift
//  BestRecipes
//
//  Created by nikita on 10.08.2025.
//

import Foundation

enum Link: String {
    case search = "https://api.spoonacular.com/recipes/complexSearch?addRecipeInformation=true&fillIngredients=true&apiKey="
    case image = "https://img.spoonacular.com/ingredients_100x100/"
}

enum RecipeType: String {
    case cuisine = "&cuisine="
    case type = "&type="
    case search = "&query="
    case trend = "&sort=meta-score&sortDirection=desc"
}

enum CuisineType: String, CaseIterable {
    case african = "African"
    case asian = "Asian"
    case american = "American"
    case british = "British"
    case cajun = "Cajun"
    case caribbean = "Caribbean"
    case chinese = "Chinese"
    case easternEuropean = "Eastern European"
    case european = "European"
    case french = "French"
    case german = "German"
    case greek = "Greek"
    case indian = "Indian"
    case irish = "Irish"
    case italian = "Italian"
    case japanese = "Japanese"
    case jewish = "Jewish"
    case korean = "Korean"
    case latinAmerican = "Latin American"
    case mediterranean = "Mediterranean"
    case mexican = "Mexican"
    case middleEastern = "Middle Eastern"
    case nordic = "Nordic"
    case southern = "Southern"
    case spanish = "Spanish"
    case thai = "Thai"
    case vietnamese = "Vietnamese"
    
    static func getRandom() -> CuisineType {
        allCases.randomElement()!
    }
}

enum MealType: String, CaseIterable {
    case mainCourse = "main course"
    case sideDish = "side dish"
    case dessert = "dessert"
    case appetizer = "appetizer"
    case salad = "salad"
    case bread = "bread"
    case breakfast = "breakfast"
    case soup = "soup"
    case beverage = "beverage"
    case sauce = "sauce"
    case marinade = "marinade"
    case fingerfood = "fingerfood"
    case snack = "snack"
    case drink = "drink"
    
    static func getRandom() -> MealType {
        allCases.randomElement()!
    }
}

enum SavedRecipesType: String {
    case mine = "myRecipes"
    case favorites = "favoritesRecipes"
    case recent = "recentRecipes"
}

enum UserSettingsLink: String {
    case onboarding
}

final class DataManager {
    static let shared = DataManager()
    
    private let fileManager: FileManager = .default
    
    private let apiKeys: [String] = [
        "cc3538ef4d1448949d8c1f17cf5703c1",
        "b00472aa0b6b4e94b37c893f41ac110c",
        "5aacdbb3cbe1434194ec06aac794bec6",
        "94a3e904ec2d4cc8bab79ce9735f4d49",
        "67815760a10949b7abd4174a271dbd1d",
        "27e0d44421784a0881805de490c3972c",
        "70566ce42eb64166a684c1f887b1e7bb",
        "36486cc9df8a4c798a7fd05ab4a8a483",
        "d5fd5ac1cb55405a8159bab08d547d52"
    ]
    
    private var imageCache: [String: Data] = [:]
    private var recipeCache: [String: [Recipe]] = [:]
    private var apiKeyIndex = 2
    
    private init() {}
    
    func completeOnboarding() {
        UserDefaults.standard.set(true, forKey: UserSettingsLink.onboarding.rawValue)
    }
    
    func isOnboardingComplete() -> Bool {
        UserDefaults.standard.bool(forKey: UserSettingsLink.onboarding.rawValue)
    }
    
    func passNextApiKey() -> Bool {
        if apiKeyIndex < apiKeys.count - 1 {
            apiKeyIndex += 1
            return true
        }
        return false
    }
    
    func getRecipes(
        type: RecipeType,
        by key: String = "",
        offset: Int = 0,
        amount: Int = 10
    ) async throws -> [Recipe] {
        
        let url = Link.search.rawValue
                  + apiKeys[apiKeyIndex]
                  + "&number=\(amount)"
                  + type.rawValue + key
                  + "&offset=\(offset)"
        
        #warning("убрать дебаг")
        print("DataManager > getRecipes() > url :", url)
        
        if let cached = recipeCache[url] {
            return cached
        }
        
        do {
            let searchResult: SearchResult = try await NetworkManager.shared.fetch(
                SearchResult.self,
                from: url
            )
            recipeCache[url] = searchResult.results
            return searchResult.results
        } catch {
            print("Ошибка загрузки рецептов: \(error)")
            return []
        }
    }
    
    func getImage(_ url: String) async throws -> Data {
        if let cached = imageCache[url] {
            return cached
        }
        
        do {
            let data = try await NetworkManager.shared.fetchImage(from: url)
            imageCache[url] = data
            return data
        } catch {
            print("Ошибка загрузки картинки: \(error)")
            return Data()
        }
    }
    
    private func fileURL(for storage: SavedRecipesType) -> URL {
        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("\(storage.rawValue).json")
    }
    
    func getRecipesFrom(_ storage: SavedRecipesType) -> [Recipe] {
        let url = fileURL(for: storage)
        
        guard fileManager.fileExists(atPath: url.path) else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let recipes = try JSONDecoder().decode([Recipe].self, from: data)
            return recipes
        } catch {
            print("Ошибка чтения рецептов из \(url.lastPathComponent):", error)
            return []
        }
    }
    
    func addRecipe(_ recipe: Recipe, to storage: SavedRecipesType) {
        var recipes = getRecipesFrom(storage)
        
        if recipes.contains(where: { $0.id == recipe.id }) { return }
        
        recipes.append(recipe)
        saveRecipes(recipes, to: storage)
    }
    
    func deleteRecipe(_ recipe: Recipe, from storage: SavedRecipesType) {
        var recipes = getRecipesFrom(storage)
        
        guard let index = recipes.firstIndex(where: { $0.id == recipe.id }) else { return }
        recipes.remove(at: index)
        
        saveRecipes(recipes, to: storage)
    }
    
    private func saveRecipes(_ recipes: [Recipe], to storage: SavedRecipesType) {
        let url = fileURL(for: storage)
        
        do {
            let data = try JSONEncoder().encode(recipes)
            try data.write(to: url, options: .atomic)
        } catch {
            print("Ошибка сохранения рецептов в \(url.lastPathComponent):", error)
        }
    }
}
