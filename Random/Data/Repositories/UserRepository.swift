//
//  UserRepository.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import Foundation

final class UserRepository: UserRepositoryType {
    private let apiDatasource: ApiDataSourceType
    private let localDatasource: LocalDataSourceType
    private let mapper: UserDTOMapper

    init(apiDatasource: ApiDataSourceType,
         localDatasource: LocalDataSourceType,
         mapper: UserDTOMapper) {
        self.apiDatasource = apiDatasource
        self.localDatasource = localDatasource
        self.mapper = mapper
    }

    func getUsers(page: Int) async throws -> [User] {
        let dtos = try await apiDatasource.getUsersList(page: page)
        let users = mapper.map(dtos)
        try await localDatasource.save(users: users)
        return users
    }

    func loadPersistedUsers() async throws -> [User] {
        return try await localDatasource.fetchAll()
    }

    func deleteUser(_ user: User) async throws {
        try await localDatasource.delete(user)
    }
}
