//
//  UserCardView.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 1.07.2025.
//

import SwiftUI

struct UserCardView: View {
    @Binding var shouldTriggerRefresh: Bool
    let user: AppUser
    var onFavoritePressed: Action<String> = nil
    
    var body: some View {
        HStack(spacing: 16) {
            UserImageView(shouldTriggerRefresh: $shouldTriggerRefresh, user: user)
                .scaledToFit()
                .frame(width: 60, height: 60)
                .background(Color(.systemGray6))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.purple.opacity(0.3), lineWidth: 2))
                .shadow(color: .purple, radius: 5)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: Constants.IconNames.favoritesFill)
                .foregroundColor(user.isFavorited ? .purple : .secondary)
                .padding(10)
                .background(user.isFavorited ? Color.purple.opacity(0.1) : .secondary.opacity(0.1))
                .clipShape(Circle())
                .onTapGesture {
                    onFavoritePressed?(user.id.description)
                }
                .animation(.bouncy, value: user.isFavorited)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .cardShadow()
        )
    }
}

#Preview {
    UserCardView(shouldTriggerRefresh: .constant(false), user: AppUser.mock)
        .padding()
}
