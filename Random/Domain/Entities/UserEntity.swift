//
//  UserEntity.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

import SwiftData
import Foundation

@Model
class UserEntity: Identifiable {
    @Attribute(.unique) var id: String
    var name: String
    var surname: String
    var email: String
    var gender: String
    var street: String
    var phone: String
    var city: String
    var state: String
    var picture: String
    var registered: String
    var orderIndex: Int
    var removed: Bool
    
    init(id: String, name: String, surname: String, email: String, gender: String, street: String, phone: String, city: String, state: String, picture: String, registered: String, orderIndex: Int, removed: Bool) {
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.gender = gender
        self.street = street
        self.phone = phone
        self.city = city
        self.state = state
        self.picture = picture
        self.registered = registered
        self.orderIndex = orderIndex
        self.removed = removed
    }
}
