//
//  CreateRecipeView.swift
//  BestRecipes
//
//  Created by Иван Семикин on 12/08/2025.
//

import SwiftUI
import PhotosUI

struct CreateRecipeView: View {
    @State private var selectedItem: PhotosPickerItem?
    @State private var uiImage: UIImage?
    
    var body: some View {
        ScrollView {
            Group {
                if let uiImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(alignment: .topTrailing) {
                            PhotosPicker(selection: $selectedItem, matching: .images) {
                                Image(systemName: "camera.on.rectangle")
                                    .padding(8)
                                    .background(.ultraThinMaterial, in: Circle())
                            }
                            .padding(10)
                        }
                        .onChange(of: selectedItem) { newValue in
                            // TODO: Implement loadImage
                            print("")
                        }
                } else {

                }
            }
        }
        .navigationTitle("Create Recipe")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    // TODO: Implement navigation back
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CreateRecipeView()
    }
}
