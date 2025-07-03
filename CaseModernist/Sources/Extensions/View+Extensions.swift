//
//  View+Extensions.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 3.07.2025.
//

import SwiftUI

extension View {
    func cardShadow(
        color: Color = .black.opacity(0.4),
        radius: CGFloat = 6,
        x: CGFloat = 0,
        y: CGFloat = 3
    ) -> some View {
        self.modifier(CardShadow(color: color, radius: radius, x: x, y: y))
    }
}

struct CardShadow: ViewModifier {
    var color: Color = .black.opacity(0.05)
    var radius: CGFloat = 10
    var x: CGFloat = 0
    var y: CGFloat = 5
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color, radius: radius, x: x, y: y)
    }
}
