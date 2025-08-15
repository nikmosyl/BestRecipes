//
//  ServesPickerSheetView.swift
//  BestRecipes
//
//  Created by Иван Семикин on 15/08/2025.
//

import SwiftUI

struct ServesPickerSheetView: View {
    @Environment(\.colorScheme) private var scheme
    @EnvironmentObject private var viewModel: CreateRecipeViewModel

    var body: some View {
        VStack(spacing: 12) {
            Capsule()
                .frame(width: 36, height: 4)
                .foregroundStyle(.secondary)
                .padding(.top, 8)

            Text("How many servings?")
                .font(.headline)

            Picker("Serves", selection: $viewModel.servings) {
                ForEach(1...20, id: \.self) { Text("\($0)") }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)
            
            Button("Done") {
                viewModel.showServesPicker.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal)
        .background(scheme == .dark ? Color.black : Color(UIColor.systemBackground))
    }
}

#Preview {
    ServesPickerSheetView()
        .environmentObject(CreateRecipeViewModel())
}
