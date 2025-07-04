//
//  AppDelegate.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 1.07.2025.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        LocalFileManager.instance.clearFolder(folderName: Constants.FolderNames.userImages)
        return true
    }
}
