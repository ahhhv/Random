//
//  SwiftDataLocalDataSource.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

import SwiftData
import Foundation

final class SwiftDataLocalDataSource: LocalDataSourceType {
    private let context: ModelContext
    private let entityMapper: UserToUserEntityMapper
    private let userMapper: EntityUserToUserMapper

    init(context: ModelContext,
         entityMapper: UserToUserEntityMapper,
         userMapper: EntityUserToUserMapper) {
        self.context = context
        self.entityMapper = entityMapper
        self.userMapper = userMapper
    }

    func save(users: [User]) async throws {
        for (index, user) in users.enumerated() {
            let entity = entityMapper.map(index: index, from: user)
            context.insert(entity)
        }
        try context.save()
    }
  
    func fetchAll() async throws -> [User] {
        do {
            let fetchDescriptor = FetchDescriptor<UserEntity>(
                sortBy: [SortDescriptor(\.orderIndex)]
            )
            let results = try context.fetch(fetchDescriptor)
            return results.map(userMapper.map)
        } catch let error as NSError {
            print("❌ Error al recuperar usuarios de SwiftData: \(error), \(error.userInfo)")
            throw error
        }
    }

    func delete(_ user: User) async throws {
        let userId = user.id
        let predicate = #Predicate<UserEntity> { $0.id == userId }

        let fetchDescriptor = FetchDescriptor<UserEntity>(predicate: predicate)
        let results = try context.fetch(fetchDescriptor)

        for entity in results {
            entity.removed = true
        }
        
        try context.save()
    }
}
