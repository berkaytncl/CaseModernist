//
//  UserDataService.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import Foundation
import Combine

@MainActor
final class UserDataService {
    @Published private var usersResponse: [UserResponse] = []
    @Published private(set) var users: [AppUser] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let favoriteUsersDataManager: FavoriteUsersDataManager
    
    init(
        favoriteUsersDataManager: FavoriteUsersDataManager
    ) {
        self.favoriteUsersDataManager = favoriteUsersDataManager
        loadUsersData()
        addSubscribers()
    }
    
    private func addSubscribers() {
        $usersResponse
            .combineLatest(favoriteUsersDataManager.$savedEntities)
            .map(mapUsersResponseToUsers)
            .sink { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
    
    private func mapUsersResponseToUsers(usersResponse: [UserResponse], savedEntities: [FavoriteUserEntity]) -> [AppUser] {
        if savedEntities.isEmpty { return usersResponse.map { $0.toAppUser() } }
        let favoritedUsers = savedEntities.compactMap { $0.id }
        return usersResponse.map { userResponse -> AppUser in
            guard favoritedUsers.first(where: { $0 == userResponse.id.description }) != nil else { return userResponse.toAppUser() }
            return userResponse.toAppUser(isFavorited: true)
        }
    }
    
    func loadUsersData() {
        getUsersData(urlString: Constants.URLs.usersData)
    }
    
    private func getUsersData(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        NetworkManager.download(url: url)
            .decode(type: [UserResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion) { [weak self] usersResponse in
                self?.usersResponse = usersResponse
            }
            .store(in: &cancellables)
    }
}
