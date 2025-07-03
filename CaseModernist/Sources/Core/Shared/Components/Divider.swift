//
//  Divider.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 2.07.2025.
//

import SwiftUI

struct Divider: View {
    let color: Color
    
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.purple.opacity(0.3))
            .padding(.horizontal)
            .padding(8)
    }
}

#Preview {
    SearchBarView(prompt: LocalizedKey.searchPlaceholderItem.localized, searchText: .constant(""))
}
