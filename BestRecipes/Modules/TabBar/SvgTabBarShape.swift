//
//  SvgTabBarShape.swift
//  BestRecipes
//
//  Created by Aleksandr Zhazhoyan on 12.08.2025.
//

import SwiftUI

struct SvgTabBarShape: Shape {
    
func path(in rect: CGRect) -> Path {
        let sx = rect.width / 375.0
        let sy = rect.height / 115.0

        var p = Path()
        p.move(to: CGPoint(x: 0*sx, y: 9*sy))
        p.addLine(to: CGPoint(x: 133.125*sx, y: 9*sy))
        p.addCurve(
            to: CGPoint(x: 155.145*sx, y: 25.0252*sy),
            control1: CGPoint(x: 142.872*sx, y: 9*sy),
            control2: CGPoint(x: 151.129*sx, y: 16.1439*sy)
        )
        p.addCurve(
            to: CGPoint(x: 188*sx, y: 50*sy),
            control1: CGPoint(x: 160.344*sx, y: 36.5251*sy),
            control2: CGPoint(x: 170.228*sx, y: 50*sy)
        )
        p.addCurve(
            to: CGPoint(x: 220.855*sx, y: 25.0252*sy),
            control1: CGPoint(x: 205.772*sx, y: 50*sy),
            control2: CGPoint(x: 215.656*sx, y: 36.5251*sy)
        )
        p.addCurve(
            to: CGPoint(x: 242.875*sx, y: 9*sy),
            control1: CGPoint(x: 224.871*sx, y: 16.1439*sy),
            control2: CGPoint(x: 233.128*sx, y: 9*sy)
        )
        p.addLine(to: CGPoint(x: 375*sx, y: 9*sy))
        p.addLine(to: CGPoint(x: 375*sx, y: 115*sy))
        p.addLine(to: CGPoint(x: 0, y: 115*sy))
        p.closeSubpath()
        return p
    }
}
