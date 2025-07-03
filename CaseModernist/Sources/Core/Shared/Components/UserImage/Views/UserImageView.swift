//
//  UserImageView.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 1.07.2025.
//

import SwiftUI

struct UserImageView: View {
    @Binding var shouldTriggerRefresh: Bool
    @StateObject var viewModel: UserImageViewModel
    
    init(shouldTriggerRefresh: Binding<Bool> = .constant(false), user: AppUser) {
        _shouldTriggerRefresh = shouldTriggerRefresh
        _viewModel = StateObject(wrappedValue: UserImageViewModel(user: user))
    }
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Circle()
                    .fill(Color.clear)
                    .overlay {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                    .clipShape(Circle())
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: Constants.IconNames.questionmark)
            }
        }
        .onChange(of: shouldTriggerRefresh) { newValue in
            if newValue {
                viewModel.reloadImage()
                DispatchQueue.main.async {
                    shouldTriggerRefresh = false
                }
            }
        }
    }
}

#Preview {
    UserImageView(shouldTriggerRefresh: .constant(false), user: AppUser.mock)
        .padding()
}
