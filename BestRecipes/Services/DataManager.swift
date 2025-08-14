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

enum MealTypes: String, CaseIterable {
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
    
    static func getRandom() -> MealTypes {
        allCases.randomElement()!
    }
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
    private var apiKeyIndex = 0
    
    private init() {}
    
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
}
