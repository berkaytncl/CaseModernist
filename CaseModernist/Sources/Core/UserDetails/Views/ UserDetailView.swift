//
//  UserDetailView.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import SwiftUI

struct UserDetailView: View {
    @EnvironmentObject private var router: Router
    
    @State var user: AppUser
    @State var onAppear = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                headerSection
                
                contactSection
                
                companySection
            }
            .frame(maxHeight: .infinity)
            .padding()
        }
        .navigationTitle(LocalizedKey.profileDetails.localized)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: router.pop) {
                    Image(systemName: Constants.IconNames.back)
                        .bold()
                    Text(.back)
                        .font(.headline)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: Constants.IconNames.favorites)
                    .foregroundColor(user.isFavorited ? .purple : .secondary)
                    .onTapGesture {
                        toggleFavorite()
                    }
            }
        }
        .animation(.bouncy, value: user.isFavorited)
    }
    
    private var headerSection: some View {
        VStack(spacing: 12) {
            UserImageView(user: user)
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.top, 20)
                .shadow(radius: 10)
            
            VStack(spacing: 4) {
                Text(user.name)
                    .font(.title).bold()
                
                Text("@" + user.username)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var contactSection: some View {
        UserDetailCardView(title: LocalizedKey.contact.localized) {
            UserDetailInfoRow(
                icon: Constants.IconNames.envelope,
                label: LocalizedKey.email.localized,
                value: user.email,
                color: .purple
            )
            
            UserDetailInfoRow(
                icon: Constants.IconNames.phone,
                label: LocalizedKey.telephone.localized,
                value: user.phone,
                color: .purple
            )
            
            UserDetailInfoRow(
                icon: Constants.IconNames.mappin,
                label: LocalizedKey.address.localized,
                value: user.address,
                color: .purple
            )
        }
    }
    
    private var companySection: some View {
        UserDetailCardView(title: LocalizedKey.company.localized) {
            UserDetailInfoRow(
                icon: Constants.IconNames.building,
                label: LocalizedKey.workplace.localized,
                value: user.company.replaceHyphenWithSpace(),
                color: .purple
            )
        }
    }
    
    private func toggleFavorite() {
        FavoriteUsersDataManager.shared.updateFavoritedUsers(id: user.id.description) {
            user.isFavorited.toggle()
        }
    }
}

#Preview {
    UserDetailView(user: AppUser.mock)
        .environmentObject(Router())
}
