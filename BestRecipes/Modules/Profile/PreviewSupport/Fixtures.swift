//
//  Fixtures.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 14.08.25.
//


import Foundation

#if DEBUG
enum Fixtures {
    // Загрузка [Recipe] из файла в Bundle
    static func loadRecipes(named file: String) -> [Recipe] {
        do {
            guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
                print(" Fixtures: '\(file).json' not found in bundle")
                return []
            }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([Recipe].self, from: data)
        } catch {
            print(" Fixtures load error:", error)
            return []
        }
    }
    
    // Разовая запись ответа в JSON (куда скажешь). Удобно вызвать из VM.
    static func saveRecipes(_ recipes: [Recipe], to path: URL) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            let data = try encoder.encode(recipes)
            try FileManager.default.createDirectory(at: path.deletingLastPathComponent(),
                                                    withIntermediateDirectories: true)
            try data.write(to: path)
            print(" Fixtures saved to:", path.path)
        } catch {
            print(" Fixtures save error:", error)
        }
    }
    
    static func defaultProjectFixturesURL(filename: String) -> URL {
        // По умолчанию пишем во временную папку и копируем файл в проект вручную.
        // На симуляторе можно писать куда угодно (например, /tmp);
        // Xcode не даст автоматически положить в каталог исходников без прав.
        return URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(filename)
    }
}
#endif
