//
//  ProfileRatingView.swift
//  BestRecipes
//
//  Created by Aleksandr Meshchenko on 14.08.25.
//


import SwiftUI

struct ProfileRatingView: View {
    var rating: Double
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "star.fill")
                .font(.caption)
                .foregroundColor(.orange)
            Text(String(format: "%.1f", rating))
                .font(.custom("Poppins-Bold", size: 14))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(UIColor.separator).opacity(0.5), lineWidth: 0.5) // iOS 16-safe
        )
    }
}

#if DEBUG
struct ProfileRatingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileRatingView(rating: 4.6).padding().previewLayout(.sizeThatFits)
            ProfileRatingView(rating: 0.0).padding().previewLayout(.sizeThatFits)
        }
        .background(Color(.systemBackground))
    }
}
#endif
