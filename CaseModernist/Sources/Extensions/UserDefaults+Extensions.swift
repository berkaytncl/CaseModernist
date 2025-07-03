//
//  UserDefaults+Extensions.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let tabSelection = "tab_selection"
    }
    
    var tabSelection: TabBarItem {
        get {
            let rawValue = UserDefaults.standard.string(forKey: Keys.tabSelection) ?? TabBarItem.users.rawValue
            return TabBarItem(rawValue: rawValue) ?? .users
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: Keys.tabSelection)
        }
    }
}
