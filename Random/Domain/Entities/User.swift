//
//  User.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import Foundation

struct User: Identifiable {
    let id: Int
    let name: String
    let surname: String
    let email: String
    let gender: String
    let street: String
    let phone: String
    let city: String
    let state: String
    let picture: String
    let registered: Date
}
