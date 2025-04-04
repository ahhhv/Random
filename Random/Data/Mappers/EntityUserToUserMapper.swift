//
//  EntityUserToUserMapper.swift
//  Random
//
//  Created by Alex Hernández on 4/4/25.
//

import Foundation

class EntityUserToUserMapper {
    func map(from user: UserEntity) -> User {
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
}
