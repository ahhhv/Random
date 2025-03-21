//
//  UserDTO.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import Foundation

struct RandomUserResponse: Codable {
    let results: [UserDTO]
}

struct UserDTO: Codable {
    let gender: String
    let name: NameDTO
    let location: LocationDTO
    let email: String
    let phone: String
    let picture: PictureDTO
    let login: LoginDTO 
    let registered: RegisteredDTO
}

struct NameDTO: Codable { let first, last: String }
struct StreetDTO: Codable { let number: Int; let name: String }
struct PictureDTO: Codable { let large: String }
struct LoginDTO: Codable { let uuid: String }
struct RegisteredDTO: Codable { let date: String }
struct LocationDTO: Codable {
    let street: StreetDTO
    let city, state, country: String
}
