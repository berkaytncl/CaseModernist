//
//  Language.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import Foundation

enum Language: String, CaseIterable {
    case en
    case tr
    
    var displayName: String {
        switch self {
        case .en:
            return "English"
        case .tr:
            return "Türkçe"
        }
    }
    
    var languageIdentifier: String {
        switch self {
        default: self.rawValue
        }
    }
}
