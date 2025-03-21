//
//  LoadUsersUseCase.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

import Foundation

protocol LoadUsersUseCaseType {
    func execute() async throws -> [User]
}

final class LoadUsersUseCase: LoadUsersUseCaseType {
    private let repository: UserRepositoryType

    init(repository: UserRepositoryType) {
        self.repository = repository
    }

    func execute() async throws -> [User] {
        return try await repository.loadPersistedUsers()
    }
}
