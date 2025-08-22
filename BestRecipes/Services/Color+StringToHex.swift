//
//  Color+StringToHex.swift
//  BestRecipes
//
//  Created by nikita on 22.08.2025.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let intValue = Int(int)
        
        let r = Int(intValue >> 16 & 0xFF)
        let g = Int(intValue >> 8 & 0xFF)
        let b = Int(intValue & 0xFF)
        
        self.init(
            red: CGFloat(r) / 255,
            green: CGFloat(g) / 255,
            blue: CGFloat(b) / 255
        )
    }
}
