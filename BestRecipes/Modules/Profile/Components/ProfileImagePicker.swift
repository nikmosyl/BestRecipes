//
//  ProfileImagePicker.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 12.08.25.
//
import SwiftUI
import PhotosUI

struct ProfileImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        config.preferredAssetRepresentationMode = .current
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ProfileImagePicker
        
        init(_ parent: ProfileImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.dismiss()
            
            guard let provider = results.first?.itemProvider,
                  provider.canLoadObject(ofClass: UIImage.self) else { return }
            
            // Используем Task для async контекста
            Task {
                do {
                    // Явно указываем тип UIImage
                    let image: UIImage = try await withCheckedThrowingContinuation { continuation in
                        provider.loadObject(ofClass: UIImage.self) { image, error in
                            if let error = error {
                                continuation.resume(throwing: error)
                            } else if let image = image as? UIImage {
                                continuation.resume(returning: image)
                            } else {
                                continuation.resume(throwing: NSError(
                                    domain: "ProfileImagePicker",
                                    code: -1,
                                    userInfo: [NSLocalizedDescriptionKey: "Failed to load image"]
                                ))
                            }
                        }
                    }
                    
                    // Обновляем на главном потоке
                    await MainActor.run {
                        parent.image = image
                    }
                } catch {
                    print("Error loading image: \(error)")
                }
            }
        }
    }
}
