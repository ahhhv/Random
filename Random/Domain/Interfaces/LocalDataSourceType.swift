//
//  LocalDataSourceType.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

import Foundation

protocol LocalDataSourceType {
    func save(users: [User]) async throws
    func fetchAll() async throws -> [User]
    func delete(_ user: User) async throws
}
