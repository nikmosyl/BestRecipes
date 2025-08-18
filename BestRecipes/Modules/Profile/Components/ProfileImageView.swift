//
//  ProfileImageView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 17.08.25.
//

import SwiftUI

struct ProfileImageView: View {
    let image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 100, height: 100)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
        .overlay(
            Image(systemName: "camera.fill")
                .font(.system(size: 16))
                .foregroundColor(.white)          // цвет иконки
                .colorInvert()                    // инверсия
                .padding(6)
                .background(Color.white)           // фон круга
                .clipShape(Circle())
                .overlay(                          // рамка вокруг синего круга
                    Circle()
                        .stroke(Color.gray, lineWidth: 1)
                )
                .offset(x: 35, y: 35)
        )
    }
}
