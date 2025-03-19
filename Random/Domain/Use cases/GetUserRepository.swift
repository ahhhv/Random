//
//  GetUserRepository.swift
//  Random
//
//  Created by Alex Hernandez Velasco on 23/2/24.
//

import Foundation

protocol GetUserRepositoryType {
    func execute(page: Int) async throws -> [User]
}

class GetUserRepository: GetUserRepositoryType {
    private let repository: UserRepositoryType

    init(repository: UserRepositoryType) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> [User] {
        return try await repository.getUsers(page: page)
    }
}
