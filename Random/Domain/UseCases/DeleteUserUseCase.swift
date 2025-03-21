//
//  DeleteUserUseCase.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

import Foundation

protocol DeleteUserUseCaseType {
    func execute(_ user: User) async throws
}

class DeleteUserUseCase: DeleteUserUseCaseType {
    private let repository: UserRepositoryType

    init(repository: UserRepositoryType) {
        self.repository = repository
    }

    func execute(_ user: User) async throws {
        try await repository.deleteUser(user)
    }
}
