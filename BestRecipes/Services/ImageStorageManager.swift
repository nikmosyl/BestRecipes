//
//  ImageStorageManager.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 23.08.25.
//

import UIKit

final class ImageStorageManager {
    static let shared = ImageStorageManager()
    
    private let fileManager = FileManager.default
    private let documentsDirectory: URL
    
    private init() {
        documentsDirectory = fileManager.urls(for: .documentDirectory, 
                                             in: .userDomainMask).first!
        createImagesDirectoryIfNeeded()
    }
    
    private var imagesDirectory: URL {
        documentsDirectory.appendingPathComponent("RecipeImages")
    }
    
    private func createImagesDirectoryIfNeeded() {
        if !fileManager.fileExists(atPath: imagesDirectory.path) {
            try? fileManager.createDirectory(at: imagesDirectory,
                                            withIntermediateDirectories: true,
                                            attributes: nil)
        }
    }
    
    /// Сохраняет изображение и возвращает путь к файлу
    func saveImage(_ image: UIImage, recipeId: Int) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        
        let fileName = "recipe_\(recipeId).jpg"
        let fileURL = imagesDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            // Возвращаем специальный префикс для локальных файлов
            return "local://\(fileName)"
        } catch {
            print("Ошибка сохранения изображения: \(error)")
            return nil
        }
    }
    
    /// Загружает изображение по пути
    func loadImage(from path: String) -> UIImage? {
        // Проверяем, что это локальный путь
        guard path.hasPrefix("local://") else { return nil }
        
        let fileName = path.replacingOccurrences(of: "local://", with: "")
        let fileURL = imagesDirectory.appendingPathComponent(fileName)
        
        guard fileManager.fileExists(atPath: fileURL.path),
              let data = try? Data(contentsOf: fileURL),
              let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
    
    /// Удаляет изображение
    func deleteImage(for recipeId: Int) {
        let fileName = "recipe_\(recipeId).jpg"
        let fileURL = imagesDirectory.appendingPathComponent(fileName)
        
        try? fileManager.removeItem(at: fileURL)
    }
    
#if DEBUG
    func printStorageInfo() {
        let files = try? FileManager.default.contentsOfDirectory(at: imagesDirectory,
                                                                includingPropertiesForKeys: nil)
        print("📁 Saved images: \(files?.count ?? 0)")
        files?.forEach { print("  - \($0.lastPathComponent)") }
    }
#endif
}
