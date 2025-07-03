//
//  Router.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 1.07.2025.
//

import SwiftUI

final class Router: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    func push(to route: AppRoutes) {
        navigationPath.append(route)
    }
    
    func pop() {
        navigationPath.removeLast()
    }
    
    func popToRoot() {
        navigationPath = .init()
    }
}

enum AppRoutes: Hashable {
    case userDetail(user: AppUser)
}
