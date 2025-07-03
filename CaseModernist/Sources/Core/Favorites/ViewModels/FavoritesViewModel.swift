//
//  FavoritesViewModel.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 1.07.2025.
//

import Foundation
import Combine

@MainActor
final class FavoritesViewModel: ObservableObject {
    @Published private(set) var favoritedUsers: [AppUser] = []
    @Published var triggerRefresh: Bool = false
    @Published var isFirstAppearance: Bool = true
    
    private let router: Router
    private let userDataService: UserDataService
    private let favoriteUsersDataManager: FavoriteUsersDataManager
    private var cancellables = Set<AnyCancellable>()
    
    init(
        router: Router,
        userDataService: UserDataService,
        favoriteUsersDataManager: FavoriteUsersDataManager
    ) {
        self.router = router
        self.userDataService = userDataService
        self.favoriteUsersDataManager = favoriteUsersDataManager
        addSubscribers()
    }
    
    private func addSubscribers() {
        userDataService.$users
            .sink { [weak self] users in
                self?.favoritedUsers = users.filter { $0.isFavorited }
            }
            .store(in: &cancellables)
    }
    
    func reloadUsersData() {
        userDataService.loadUsersData()
    }
    
    func updateFavoritedUser(id: String) {
        favoriteUsersDataManager.updateFavoritedUsers(id: id)
    }
    
    // MARK: - Navigation Actions
    func navigateToUserDetail(user: AppUser) {
        router.push(to: .userDetail(user: user))
    }
}
