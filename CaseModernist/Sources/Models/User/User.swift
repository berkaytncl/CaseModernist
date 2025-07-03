//
//  User.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import Foundation

struct UserResponse: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

struct AppUser: Identifiable, Hashable {
    private let response: UserResponse
    var id: Int { response.id }
    var name: String { response.name }
    var username: String { response.username }
    var email: String { response.email }
    var address: String { response.address.street + " " + response.address.suite + " " + response.address.city + " " + response.address.zipcode }
    var phone: String { response.phone }
    var website: String { response.website }
    var company: String { response.company.name }
    var isFavorited: Bool
    
    init(response: UserResponse, isFavorited: Bool = false) {
        self.response = response
        self.isFavorited = isFavorited
    }
}

extension UserResponse {
    func toAppUser(isFavorited: Bool = false) -> AppUser {
        .init(response: self, isFavorited: isFavorited)
    }
}

extension AppUser {
    static let mock: AppUser = {
        .init(response: UserResponse.init(
            id: 1,
            name: "Leanne Graham",
            username: "Bret",
            email: "Sincere@april.biz",
            address: Address(
                street: "Kulas Light",
                suite: "Apt. 556",
                city: "Gwenborough",
                zipcode: "92998-3874",
                geo: Geo(
                    lat: "-37.3159",
                    lng: "81.1496"
                )
            ),
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: Company(
                name: "Romaguera-Crona",
                catchPhrase: "Multi-layered client-server neural-net",
                bs: "harness real-time e-markets"
            )
        ))
    }()
}
