//
//  UserDetailInfoRow.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 3.07.2025.
//

import SwiftUI

struct UserDetailInfoRow: View {
    let icon: String
    let label: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .frame(width: 24)
                Text(label)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            
            Text(value)
                .font(.body)
                .padding(.leading, 32)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    UserDetailInfoRow(
        icon: Constants.IconNames.envelope,
        label: LocalizedKey.email.localized,
        value: AppUser.mock.email,
        color: .purple
    )
}
