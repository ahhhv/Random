//
//  UserRepository.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import Foundation

class UserRepository: UserRepositoryType {
    private let apiDatasource: ApiDataSourceType
    private let mapper: UserMapper
    
    init(apiDatasource: ApiDataSourceType, mapper: UserMapper) {
        self.apiDatasource = apiDatasource
        self.mapper = mapper
    }

    func getUsers(page: Int) async throws -> [User] {
        let usersData = try await apiDatasource.getUsersList(page: page)
        return mapper.map(usersData)
    }
}

