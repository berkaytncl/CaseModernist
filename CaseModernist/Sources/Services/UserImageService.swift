//
//  UserImageService.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import SwiftUI
import Combine

final class UserImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let user: AppUser
    private let fileManager = LocalFileManager.instance
    private let folderName = Constants.FolderNames.userImages
    private let imageName: String
    
    init(user: AppUser) {
        self.user = user
        imageName = user.id.description
        reloadImage()
    }
    
    func reloadImage() {
        getUserImage()
    }
    
    private func getUserImage() {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadUserImage()
        }
    }
     
    private func downloadUserImage() {
        guard let url = URL(string: Constants.URLs.randomImage) else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion,
                  receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: imageName, folderName: folderName)
            })
    }
}
