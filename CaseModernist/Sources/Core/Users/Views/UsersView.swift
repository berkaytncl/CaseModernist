//
//  UsersView.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import SwiftUI

struct UsersView: View {
    @EnvironmentObject private var router: Router
    @StateObject var viewModel: UsersViewModel
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack {
                Divider(color: .purple)
                
                SearchBarView(
                    prompt: LocalizedKey.searchPlaceholderItem.localized,
                    searchText: $viewModel.searchText
                )
                .padding(8)
                
                userCardsView
            }
            .navigationTitle(LocalizedKey.users.localized)
            .navigationDestination(for: AppRoutes.self) { route in
                switch route {
                case .userDetail(let user):
                    UserDetailView(user: user)
                }
            }
            .onAppear { viewModel.isFirstAppearance ? viewModel.isFirstAppearance.toggle() : viewModel.triggerRefresh.toggle() }
        }
    }
    
    private var userCardsView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(Array(viewModel.filteredUsers.enumerated()), id: \.element.id) { index, user in
                UserCardView(
                    shouldTriggerRefresh: $viewModel.triggerRefresh,
                    user: user,
                    onFavoritePressed: viewModel.updateFavoritedUser
                )
                .onTapGesture {
                    viewModel.navigateToUserDetail(user: user)
                }
                .padding(8)
                .padding(.horizontal, 16)
            }
            .padding(.bottom)
        }
        .refreshable {
            LocalFileManager.instance.clearFolder(folderName: Constants.FolderNames.userImages)
            viewModel.triggerRefresh.toggle()
            viewModel.reloadUsersData()
        }
    }
}

#Preview {
    let favoriteUsersDataManager = FavoriteUsersDataManager.shared
    let router = Router()
    
    UsersView(
        viewModel: UsersViewModel(
            router: router,
            userDataService: UserDataService(favoriteUsersDataManager: favoriteUsersDataManager),
            favoriteUsersDataManager: favoriteUsersDataManager
        )
    )
    .environmentObject(router)
}
