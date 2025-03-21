//
//  UserMapperTests.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

import XCTest
@testable import Random

final class UserMapperTests: XCTestCase {
    
    func test_map_returnsMappedUser() {
        // Given
        let dto = UserDTO(
            gender: "male",
            name: NameDTO(first: "Alex", last: "Hernandez"),
            location: LocationDTO(
                street: StreetDTO(number: 123, name: "Calle falsa"),
                city: "Sant Feliu de Llobregat",
                state: "Barcelona",
                country: "Spain"
            ),
            email: "alex@example.com",
            phone: "987654321",
            picture: PictureDTO(large: "https://example.com/alex.jpg"),
            login: LoginDTO(uuid: "login-uuid"),
            registered: RegisteredDTO(date: "2023-12-01")
        )
        
        let mapper = UserMapper()
        
        // When
        let users = mapper.map([dto])
        
        // Then
        XCTAssertEqual(users.count, 1)
        let user = users[0]
        
        XCTAssertEqual(user.name, "Alex")
        XCTAssertEqual(user.surname, "Hernandez")
        XCTAssertEqual(user.email, "alex@example.com")
        XCTAssertEqual(user.gender, "male")
        XCTAssertEqual(user.street, "Calle falsa")
        XCTAssertEqual(user.city, "Sant Feliu de Llobregat")
        XCTAssertEqual(user.state, "Barcelona")
        XCTAssertEqual(user.phone, "987654321")
        XCTAssertEqual(user.picture, "https://example.com/alex.jpg")
        XCTAssertEqual(user.registered, "2023-12-01")
        XCTAssertFalse(user.id.isEmpty)
    }
}
