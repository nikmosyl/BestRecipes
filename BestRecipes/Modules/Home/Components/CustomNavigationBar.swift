//
//  CustomNavigationBar.swift
//  BestRecipes
//
//  Created by nikita on 25.08.2025.
//

import SwiftUI

struct CustomNavigationBar: View {
    var title: String
    
    var body: some View {
        ZStack {
            Color.clear
                .background(Material.ultraThin)
                .ignoresSafeArea(edges: .top)
            
            HStack(spacing: 12) {
                
                Text(title)
                    .font(.custom("Poppins-SemiBold", size: 24))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 60)
    }
}


#Preview {
    CustomNavigationBar(title: "Тест очень длинной строки для нав бара")
}
