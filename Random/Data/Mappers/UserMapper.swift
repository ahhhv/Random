//
//  UserMapper.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import Foundation

class UserMapper {
    func map(_ users: [UserDTO]) -> [User] {
        return users.map { dto in
            User(
                id: UUID().hashValue,
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
