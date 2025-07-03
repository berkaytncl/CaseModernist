//
//  String+Extensions.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 1.07.2025.
//

import Foundation

extension String {
    func replaceHyphenWithSpace() -> String {
        replacingOccurrences(of: "-", with: " ")
    }
}
