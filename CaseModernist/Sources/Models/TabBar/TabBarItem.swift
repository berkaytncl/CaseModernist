//
//  TabBarItem.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import Foundation

enum TabBarItem: String {
    case users, favorites, settings
    
    var iconName: String {
        switch self {
        case .users: Constants.IconNames.users
        case .favorites: Constants.IconNames.favorites
        case .settings: Constants.IconNames.settings
        }
    }
    
    var title: String {
        switch self {
        case .users: LocalizedKey.users.localized
        case .favorites: LocalizedKey.favorites.localized
        case .settings: LocalizedKey.settings.localized
        }
    }
}
