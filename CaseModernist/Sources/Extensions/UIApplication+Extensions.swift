//
//  UIApplication+Extensions.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
