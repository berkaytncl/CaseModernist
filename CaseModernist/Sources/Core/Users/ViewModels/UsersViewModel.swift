//
//  UsersViewModel.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 1.07.2025.
//

import Foundation
import Combine

@MainActor
final class UsersViewModel: ObservableObject {
    @Published private var users: [AppUser] = []
    @Published private(set) var filteredUsers: [AppUser] = []
    @Published var triggerRefresh: Bool = false
    @Published var isFirstAppearance: Bool = true
    @Published var searchText = ""
    
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
                self?.users = users
            }
            .store(in: &cancellables)
        
        $searchText
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .combineLatest($users)
            .map(mapUsersToFilteredUsers)
            .sink { [weak self] filteredUsers in
                self?.filteredUsers = filteredUsers
            }
            .store(in: &cancellables)
    }
    
    private func mapUsersToFilteredUsers(filterKey: String, users: [AppUser]) -> [AppUser] {
        guard !filterKey.isEmpty else { return users }
        
        return users.filter { $0.name.lowercased().contains(filterKey.lowercased()) }
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
