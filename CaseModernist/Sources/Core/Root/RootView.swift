//
//  RootView.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import SwiftUI
import Combine

struct RootView: View {
    @State private var currentLocale: Locale = .current
    @State private var tabSelection: TabBarItem
    
    @StateObject private var usersRouter = Router()
    @StateObject private var favoritesRouter = Router()
    
    private let userDataService: UserDataService
    private let favoriteUsersDataManager: FavoriteUsersDataManager
    
    init() {
        let tabSelection = UserDefaults.standard.tabSelection
        self.tabSelection = tabSelection == .settings ? .users : tabSelection
        
        self.favoriteUsersDataManager = FavoriteUsersDataManager.shared
        self.userDataService = UserDataService(favoriteUsersDataManager: favoriteUsersDataManager)
    }
    
    var body: some View {
        tabBarSection
            .id(currentLocale.identifier)
    }
    
    @MainActor
    private var tabBarSection: some View {
        TabView(selection: $tabSelection) {
            UsersView(
                viewModel: UsersViewModel(
                    router: usersRouter,
                    userDataService: userDataService,
                    favoriteUsersDataManager: favoriteUsersDataManager
                )
            )
            .tabItem {
                Label(
                    TabBarItem.users.title,
                    systemImage: TabBarItem.users.iconName
                )
            }
            .tag(TabBarItem.users)
            .environmentObject(usersRouter)
            
            FavoritesView(
                viewModel: FavoritesViewModel(
                    router: favoritesRouter,
                    userDataService: userDataService,
                    favoriteUsersDataManager: favoriteUsersDataManager
                )
            )
            .tabItem {
                Label(
                    TabBarItem.favorites.title,
                    systemImage: TabBarItem.favorites.iconName
                )
            }
            .tag(TabBarItem.favorites)
            .environmentObject(favoritesRouter)
            
            SettingsView(locale: $currentLocale)
                .tabItem {
                    Label(
                        TabBarItem.settings.title,
                        systemImage: TabBarItem.settings.iconName
                    )
                }
                .tag(TabBarItem.settings)
        }
        .tint(.purple)
        .onChange(of: tabSelection) { newValue in
            UserDefaults.standard.tabSelection = newValue
        }
    }
}

#Preview {
    RootView()
}
