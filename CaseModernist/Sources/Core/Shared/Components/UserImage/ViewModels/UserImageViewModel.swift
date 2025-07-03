//
//  UserImageViewModel.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 1.07.2025.
//

import SwiftUI
import Combine

final class UserImageViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let user: AppUser
    private let dataService: UserImageService
    private var cancellables = Set<AnyCancellable>()
    
    init(user: AppUser) {
        self.user = user
        dataService = UserImageService(user: user)
        addSubscribers()
        isLoading = true
    }
    
    func reloadImage() {
        isLoading = true
        image = nil
        dataService.reloadImage()
    }
    
    private func addSubscribers() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &cancellables)
    }
}
