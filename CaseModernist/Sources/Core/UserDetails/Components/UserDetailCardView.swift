//
//  UserDetailCardView.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 3.07.2025.
//

import SwiftUI

struct UserDetailCardView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .padding(.bottom, 4)
            
            VStack(spacing: 0) {
                content
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .cardShadow()
        )
    }
}
