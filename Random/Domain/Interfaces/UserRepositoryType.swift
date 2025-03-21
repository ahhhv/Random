//
//  UserRepositoryType.swift
//  Random
//
//  Created by Alex Hernandez Velasco on 23/2/24.
//

import Foundation

protocol UserRepositoryType {
    func getUsers(page: Int) async throws -> [User]
    func loadPersistedUsers() async throws -> [User]
    func deleteUser(_ user: User) async throws
}
