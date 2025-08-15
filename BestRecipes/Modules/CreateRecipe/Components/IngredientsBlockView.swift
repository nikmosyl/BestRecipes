//
//  IngredientsBlockView.swift
//  BestRecipes
//
//  Created by Иван Семикин on 15/08/2025.
//

import SwiftUI

struct IngredientsBlockView: View {
    @EnvironmentObject private var viewModel: CreateRecipeViewModel

    var body: some View {
        VStack(spacing: 12) {
            Text("Ingredients")
                .font(.system(size: 20, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)

            IngredientRowView(
                name: $viewModel.newIngredient.name,
                quantity: $viewModel.newIngredient.quantity,
                isNew: true,
                onAdd: {
                    guard !viewModel.newIngredient.name.trimmingCharacters(in: .whitespaces).isEmpty,
                          viewModel.newIngredient.quantity > 0 else { return }
                    viewModel.ingredients.append(
                        Ingredient(
                            id: Int.random(in: 1...10_000),
                            name: viewModel.newIngredient.name,
                            amount: viewModel.newIngredient.quantity,
                            imageName: ""
                        )
                    )
                    viewModel.newIngredient = ("", 0)
                }
            )

            ForEach(Array(viewModel.ingredients.enumerated()), id: \.offset) { index, ingredient in
                IngredientRowView(
                    savedName: ingredient.name,
                    savedQuantity: ingredient.amount,
                    isNew: false,
                    onRemove: { viewModel.ingredients.remove(at: index) }
                )
            }
        }
    }
}

private struct IngredientRowView: View {
    var name: Binding<String>?
    var quantity: Binding<Double>?
    var savedName: String = ""
    var savedQuantity: Double = 0
    var isNew: Bool
    var onAdd: (() -> Void)?
    var onRemove: (() -> Void)?

    @FocusState private var isQuantityFocused: Bool

    private let numberFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .decimal
        f.minimumFractionDigits = 0
        f.maximumFractionDigits = 2
        f.zeroSymbol = ""
        return f
    }()

    var body: some View {
        HStack(spacing: 10) {
            if isNew, let name, let quantity {
                TextField("Item name", text: name)
                    .textFieldStyle(.roundedBorder)

                ZStack(alignment: .leading) {
                    TextField("", value: quantity, formatter: numberFormatter)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .focused($isQuantityFocused)

                    if quantity.wrappedValue == 0 && !isQuantityFocused {
                        Text("Quantity")
                            .foregroundStyle(.secondary)
                            .padding(.leading, 6)
                            .allowsHitTesting(false)
                    }
                }
                .frame(width: 110)

                Button(action: { onAdd?() }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.green)
                }
                .disabled(!canAdd(name: name.wrappedValue, quantity: quantity.wrappedValue))
                .opacity(canAdd(name: name.wrappedValue, quantity: quantity.wrappedValue) ? 1 : 0.4)
            } else {
                TextField("", text: .constant(savedName.isEmpty ? "—" : savedName))
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)

                TextField("", text: .constant("\(quantityString(savedQuantity)) gr"))
                    .textFieldStyle(.roundedBorder)
                    .disabled(true)
                    .frame(width: 110)

                Button(action: { onRemove?() }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.red)
                }
            }
        }
    }

    private func quantityString(_ value: Double) -> String {
        value.rounded() == value ? String(Int(value)) : String(format: "%.2f", value)
    }

    private func canAdd(name: String, quantity: Double) -> Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty && quantity > 0
    }
}

#Preview {
    IngredientsBlockView()
        .environmentObject(CreateRecipeViewModel())
}
