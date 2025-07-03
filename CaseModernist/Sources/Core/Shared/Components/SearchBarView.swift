//
//  SearchBarView.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import SwiftUI

struct SearchBarView: View {
    var prompt: String
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: Constants.IconNames.magnifyingglass)
                .foregroundStyle(
                    searchText.isEmpty ? Color.secondary : .purple.opacity(0.1)
                )
            
            TextField(text: $searchText, axis: .horizontal) {
                Text(prompt)
                    .foregroundStyle(.secondary)
            }
            .autocorrectionDisabled()
            .tint(.secondary)
            .overlay(
                Image(systemName: Constants.IconNames.xmark)
                    .padding()
                    .offset(x: 10)
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        searchText = ""
                    }
                , alignment: .trailing
            )
        }
        .animation(.bouncy, value: searchText)
        .font(.headline)
        .foregroundStyle(.primary)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(.purple.opacity(0.1))
        )
        .padding(.horizontal)
    }
}

#Preview {
    SearchBarView(prompt: LocalizedKey.searchPlaceholderItem.localized, searchText: .constant(""))
}
