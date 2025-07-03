//
//  CaseModernistApp.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import SwiftUI

@main
struct CaseModernistApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                RootView()
                
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                        .transition(.move(edge: .leading))
                }
            }
        }
    }
}
