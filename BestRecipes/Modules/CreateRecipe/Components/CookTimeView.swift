//
//  CookTimeView.swift
//  BestRecipes
//
//  Created by Иван Семикин on 15/08/2025.
//

import SwiftUI

struct CookTimeView: View {
    @EnvironmentObject private var viewModel: CreateRecipeViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "clock.fill")
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.white)
                }
            
            Text("Cook Time")
                .font(.system(size: 16, weight: .semibold))
            
            Spacer()
            
            Text("\(viewModel.readyInMinutes) min")
                .foregroundStyle(.gray)
            
            Button {
                viewModel.showCookTimePicker.toggle()
            } label: {
                Image(systemName: "arrow.right")
                    .foregroundStyle(.black)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.gray.opacity(0.1))
        }
    }
}

#Preview {
    CookTimeView()
        .environmentObject(CreateRecipeViewModel())
}
