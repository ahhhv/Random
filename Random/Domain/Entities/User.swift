//
//  User.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import Foundation

struct User: Identifiable, Hashable {
    var id: String
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
    var removed: Bool? = false
    
    var fullName: String {
        "\(name) \(surname)"
    }
}
