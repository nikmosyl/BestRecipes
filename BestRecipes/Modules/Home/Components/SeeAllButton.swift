//
//  SeeAllButton.swift
//  BestRecipes
//
//  Created by nikita on 24.08.2025.
//

import SwiftUI

struct SeeAllButton: View {
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Text("See all")
                .foregroundStyle(Color(hex: "#E23E3E"))
                .font(.custom("Poppins-SemiBold", size: 14))
            
            Image(systemName: "arrow.right")
                .foregroundColor(.black)
        }
    }
}

#Preview {
    SeeAllButton(action: {})
}
