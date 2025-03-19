//
//  UserRepository.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import Foundation

class UserRepository: UserRepositoryType {
    private let apiDatasource: ApiDataSourceType
    
    init(apiDatasource: ApiDataSourceType) {
        self.apiDatasource = apiDatasource
    }

    func getUsers(page: Int) async throws -> [User] {
        let usersData = try await apiDatasource.getUsersList(page: page)
        return usersData.map { dto in
            User(
                name: dto.name.first,
                surname: dto.name.last,
                email: dto.email,
                gender: dto.gender,
                street: dto.location.street.name,
                phone: dto.phone,
                city: dto.location.city,
                state: dto.location.state,
                picture: dto.picture.large,
                registered: ISO8601DateFormatter().date(from: dto.registered.date) ?? Date()
            )
        }
    }
}

