//
//  CuisineSection.swift
//  BestRecipes
//
//  Created by nikita on 25.08.2025.
//

import SwiftUI

struct CuisineSection: View {
    @State var seeAll = false
    
    let cuisines = CuisineType.allCases
    
    var body: some View {
        HStack {
            Text("Trending now")
                .font(.custom("Poppins-SemiBold", size: 20))
            
            Spacer()
        }
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(cuisines, id: \.self) { cuisine in
                    CuisineCell(cuisine: cuisine)
                }
            }
        }
    }
}

#Preview {
    CuisineSection()
}
