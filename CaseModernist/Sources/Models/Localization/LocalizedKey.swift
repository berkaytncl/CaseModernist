//
//  LocalizedKey.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import Foundation

enum LocalizedKey: String {
    case appName = "app_name"
    case users
    case favorites
    case settings
    case searchPlaceholderItem = "search_placeholder_item"
    case profileDetails = "profile_details"
    case email
    case contact
    case telephone
    case address
    case company
    case workplace
    case back
    case emptyFavorites = "empty_favorites"
    case applicationSettings = "application_settings"
    case language
    case loadingLaunch = "loading_launch"

    var localized: String {
        LanguageManager.shared.localizedString(for: self.rawValue)
    }
    
    func localized(with arguments: CVarArg...) -> String {
        LanguageManager.shared.localizedString(for: self.rawValue, with: arguments)
    }
}
