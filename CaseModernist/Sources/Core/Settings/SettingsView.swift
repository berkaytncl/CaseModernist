//
//  SettingsView.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 1.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @Binding var currentLocale: Locale
    @State private var selectedLanguage: Language
    @State private var showLogoutAlert = false
    
    private let languageManager = LanguageManager.shared
    
    init(locale: Binding<Locale>) {
        _currentLocale = locale
        selectedLanguage = languageManager.selectedLanguage
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Divider(color: .purple)
                
                List {
                    Section(header: Text(.applicationSettings)) {
                        Picker(LocalizedKey.language.localized, selection: $selectedLanguage) {
                            ForEach(Language.allCases, id: \.self) {
                                Text($0.displayName)
                                    .tag($0.rawValue)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(.white)
            .listStyle(.insetGrouped)
            .navigationTitle(LocalizedKey.settings.localized)
            .onChange(of: selectedLanguage, perform: changeLanguage)
        }
    }
    
    private func changeLanguage(to language: Language) {
        guard let languageIdentifier = Locale.availableIdentifiers.first(where: { $0.contains(language.languageIdentifier) }) else { return }
        languageManager.selectedLanguage = language
        currentLocale = Locale(identifier: languageIdentifier)
    }
}

#Preview {
    SettingsView(locale: .constant(.current))
}
