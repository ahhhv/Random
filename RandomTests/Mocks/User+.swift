//
//  User+.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

@testable import Random
import Foundation

extension User {
    static func dummy() -> User {
        User(
            id: UUID().uuidString,
            name: "Alex",
            surname: "Hernández",
            email: "alexhernandez@example.com",
            gender: "male",
            street: "Calle Falsa 123",
            phone: "123456789",
            city: "Sant Feliu de Llobregat",
            state: "Spain",
            picture: "",
            registered: "",
            removed: false
        )
    }
}
