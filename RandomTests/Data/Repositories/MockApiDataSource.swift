//
//  MockApiDataSource.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

@testable import Random

final class MockApiDataSource: ApiDataSourceType {
    var stubbedUsers: [UserDTO] = []
    var shouldThrowError = false
    var getUsersListCalled = false

    func getUsersList(page: Int) async throws -> [UserDTO] {
        getUsersListCalled = true
        if shouldThrowError { throw APIError.responseError }
        return stubbedUsers
    }
}

final class MockLocalDataSource: LocalDataSourceType {
    var stubbedUsers: [User] = []
    var fetchAllCalled = false
    var saveCalled = false
    var deleteCalled = false
    var savedUsers: [User]?

    func fetchAll() async throws -> [User] {
        fetchAllCalled = true
        return stubbedUsers
    }

    func save(users: [User]) async throws {
        saveCalled = true
        savedUsers = users
    }

    func delete(_ user: User) async throws {
        deleteCalled = true
    }
}

final class MockUserMapper: UserMapper {
    var stubbedUsers: [User] = []

    override func map(_ users: [UserDTO]) -> [User] {
        return stubbedUsers
    }
}
