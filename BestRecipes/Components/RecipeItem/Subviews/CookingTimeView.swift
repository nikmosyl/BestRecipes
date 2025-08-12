//
//  CookingTimeView.swift
//  BestRecipes
//
//  Created by Mikhail Ustyantsev on 12.08.2025.
//

import SwiftUI

struct CookingTimeView: View {
    var cookingInMinutes: Int 
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.6), strokeBorder: .clear)
                .frame(width: 60, height: 30)
            
            Text(formatTime(minutes: cookingInMinutes))
                .foregroundStyle(.white)
                .font(.custom("Poppins-Regular", size: 14))
        }
    }
    
    private func formatTime(minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        return String(format: "%02d:%02d", hours, mins)
    }
}

#Preview {
    CookingTimeView(cookingInMinutes: 30)
}
