//
//  GetUsersUseCase.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

import Foundation

protocol GetUsersUseCaseType {
    func execute(page: Int) async throws -> [User]
}

final class GetUsersUseCase: GetUsersUseCaseType {
    private let repository: UserRepositoryType

    init(repository: UserRepositoryType) {
        self.repository = repository
    }

    func execute(page: Int) async throws -> [User] {
        return try await repository.getUsers(page: page)
    }
}
