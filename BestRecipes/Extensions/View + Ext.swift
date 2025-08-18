//
//  View + Ext.swift
//  BestRecipes
//
//  Created by Иван Семикин on 15/08/2025.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboardOnTap() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
