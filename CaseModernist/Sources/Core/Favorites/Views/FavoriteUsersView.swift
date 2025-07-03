//
//  FavoritesView.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var router: Router
    @StateObject var viewModel: FavoritesViewModel
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack {
                Divider(color: .purple)
                
                if viewModel.favoritedUsers.isEmpty {
                    emptyListView
                } else {
                    userCardsView
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle(LocalizedKey.favorites.localized)
            .navigationDestination(for: AppRoutes.self) { route in
                switch route {
                case .userDetail(let user):
                    UserDetailView(user: user)
                }
            }
            .animation(.bouncy, value: viewModel.favoritedUsers.isEmpty)
            .onAppear { viewModel.isFirstAppearance ? viewModel.isFirstAppearance.toggle() : viewModel.triggerRefresh.toggle() }
        }
    }
    
    private var userCardsView: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(Array(viewModel.favoritedUsers.enumerated()), id: \.element.id) { index, user in
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
    
    private var emptyListView: some View {
        VStack {
            Image(systemName: Constants.IconNames.list)
                .font(.system(size: 48))
                .padding()
            Text(.emptyFavorites)
                .font(.title)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    let favoriteUsersDataManager = FavoriteUsersDataManager.shared
    let router = Router()
    
    FavoritesView(
        viewModel: FavoritesViewModel(
            router: router,
            userDataService: UserDataService(favoriteUsersDataManager: favoriteUsersDataManager),
            favoriteUsersDataManager: favoriteUsersDataManager
        )
    )
    .environmentObject(router)
}
