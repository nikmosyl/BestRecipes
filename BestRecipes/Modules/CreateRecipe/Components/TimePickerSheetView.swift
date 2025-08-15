//
//  TimePickerSheetView.swift
//  BestRecipes
//
//  Created by Иван Семикин on 15/08/2025.
//

import SwiftUI

struct TimePickerSheetView: View {
    @Environment(\.colorScheme) private var scheme
    @EnvironmentObject private var viewModel: CreateRecipeViewModel
    
    private let range = 1...240

    var body: some View {
        VStack(spacing: 12) {
            Capsule()
                .frame(width: 36, height: 4)
                .foregroundStyle(.secondary)
                .padding(.top, 8)

            Text("How long does it take?")
                .font(.headline)

            Picker("Cook time (min)", selection: $viewModel.readyInMinutes) {
                ForEach(range, id: \.self) { value in
                    Text("\(value) min")
                        .tag(value)
                }
            }
            .labelsHidden()
            .pickerStyle(.wheel)
            .frame(height: 150)

            Button("Done") {
                viewModel.showCookTimePicker.toggle()
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 10)
        }
        .padding(.horizontal)
    }
}

#Preview {
    TimePickerSheetView()
        .environmentObject(CreateRecipeViewModel())
}
