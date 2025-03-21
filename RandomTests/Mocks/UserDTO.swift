//
//  UserDTO.swift
//  RandomTests
//
//  Created by Alex Hernández on 21/3/25.
//

@testable import Random

extension UserDTO {
    static func dummy() -> UserDTO {
        UserDTO(
            gender: "Male",
            name: NameDTO(first: "Alex", last: "Hernández"),
            location: LocationDTO(street: StreetDTO(number: 123, name: "Calle Falsa"),
                                  city: "Sant Feliu de Llobregat", state: "Barcelona", country: "Spain"),
            email: "alex@example.com",
            phone: "+34 600 123 456",
            picture: PictureDTO(large: "www.example.com"),
            login: LoginDTO(uuid: "23y987243987234"),
            registered: RegisteredDTO(date: "")
        )
    }
}
