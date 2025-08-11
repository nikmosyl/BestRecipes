//
//  RatingView.swift
//  BestRecipes
//
//  Created by Mikhail Ustyantsev on 11.08.2025.
//

import SwiftUI

struct RatingView: View {
    @State var rating: Double = 5.0
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.6), strokeBorder: .clear)
                .frame(width: 80, height: 35)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.black)
                
                Text(String(format: "%.1f", rating))
                    .bold()
                    .foregroundStyle(.white)
            }
            
        }
    }
}

#Preview {
    RatingView()
}
