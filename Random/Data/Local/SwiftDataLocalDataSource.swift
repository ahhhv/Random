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

    init(context: ModelContext) {
        self.context = context
    }

    func save(users: [User]) async throws {
        for (index, user) in users.enumerated() {
            let entity = UserEntity(
                id: user.id,
                name: user.name,
                surname: user.surname,
                email: user.email,
                gender: user.gender,
                street: user.street,
                phone: user.phone,
                city: user.city,
                state: user.state,
                picture: user.picture,
                registered: user.registered,
                orderIndex: index,
                removed: user.removed ?? false
            )
            context.insert(entity)
        }
        try context.save()
    }

    func fetchAll() async throws -> [User] {
        do {
            let fetchDescriptor = FetchDescriptor<UserEntity>(
                    predicate: #Predicate<UserEntity> { !$0.removed },
                    sortBy: [SortDescriptor(\.orderIndex)]
                )
            let results = try context.fetch(fetchDescriptor)
            
            return results.map { user in
                User(
                    id: user.id,
                    name: user.name,
                    surname: user.surname,
                    email: user.email,
                    gender: user.gender,
                    street: user.street,
                    phone: user.phone,
                    city: user.city,
                    state: user.state,
                    picture: user.picture,
                    registered: user.registered,
                    removed: user.removed
                )
            }
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
