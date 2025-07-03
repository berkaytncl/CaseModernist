//
//  Text+Extensions.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import SwiftUI

extension Text {
    init(_ key: LocalizedKey) {
        self.init(key.localized)
    }
    
    init(_ key: LocalizedKey, with arguments: CVarArg...) {
        self.init(key.localized(with: arguments))
    }
}
