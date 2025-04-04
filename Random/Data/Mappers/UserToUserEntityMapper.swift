//
//  UserToUserEntityMapper.swift
//  Random
//
//  Created by Alex Hernández on 4/4/25.
//


import Foundation

class UserToUserEntityMapper {
    func map(index: Int, from user: User) -> UserEntity {
        return UserEntity(
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
            removed: user.removed
        )
    }
}
