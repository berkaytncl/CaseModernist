//
//  FavoriteUsersDataManager.swift
//  CaseModernist
//
//  Created by Berkay Tuncel on 30.06.2025.
//

import Foundation
import CoreData

@MainActor
final class FavoriteUsersDataManager {
    static let shared = FavoriteUsersDataManager()

    private let container: NSPersistentContainer
    private let containerName: String = "FavoriteUserContainer"
    private let entityName: String = "FavoriteUserEntity"
    
    @Published private(set) var savedEntities: [FavoriteUserEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                debugPrint("Error loading Core Data! \(error)")
            }
            try? self.getSavedFavoriteUsers()
        }
    }
    
    // MARK: PUBLIC
    
    func updateFavoritedUsers(id: String, completion: (() -> ())? = nil) {
        if let entity = savedEntities.first(where: { $0.id == id }) {
            try? delete(entity: entity) { completion?() }
        } else {
            try? add(id: id) { completion?() }
        }
    }
    
    // MARK: PRIVATE
    
    private func getSavedFavoriteUsers() throws {
        let request = NSFetchRequest<FavoriteUserEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            debugPrint("Error fetching Portfolio Entities. \(error)")
            throw error
        }
    }
    
    private func add(id: String, completion: (() -> ())? = nil) throws {
        let entity = FavoriteUserEntity(context: container.viewContext)
        entity.id = id
        try applyChanges()
        completion?()
    }
    
    private func delete(entity: FavoriteUserEntity, completion: (() -> ())? = nil) throws {
        container.viewContext.delete(entity)
        try applyChanges()
        completion?()
    }
    
    private func applyChanges() throws {
        try save()
        try getSavedFavoriteUsers()
    }
    
    private func save() throws {
        do {
            try container.viewContext.save()
        } catch {
            debugPrint("Error saving to Core Data. \(error)")
            throw error
        }
    }
}

