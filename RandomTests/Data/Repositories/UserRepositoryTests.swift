//
//  UserRepositoryTests.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//


import XCTest
@testable import Random

final class UserRepositoryTests: XCTestCase {
    var sut: UserRepository!
    var mockApiDataSource: MockApiDataSource!
    var mockLocalDataSource: MockLocalDataSource!
    var mockMapper: MockUserMapper!

    override func setUpWithError() throws {
        mockApiDataSource = MockApiDataSource()
        mockLocalDataSource = MockLocalDataSource()
        mockMapper = MockUserMapper()
        
        sut = UserRepository(
            apiDatasource: mockApiDataSource,
            localDatasource: mockLocalDataSource,
            mapper: mockMapper
        )
    }

    override func tearDownWithError() throws {
        sut = nil
        mockApiDataSource = nil
        mockLocalDataSource = nil
        mockMapper = nil
    }

    func test_getUsers_callsApiAndSavesToLocal() async throws {
        // GIVEN
        let dtoUsers = [UserDTO.dummy(), UserDTO.dummy()]
        let mappedUsers = [User.dummy(), User.dummy()]

        mockApiDataSource.stubbedUsers = dtoUsers
        mockMapper.stubbedUsers = mappedUsers

        // WHEN
        let users = try await sut.getUsers(page: 1)

        // THEN
        XCTAssertEqual(users.count, 2)
        XCTAssertTrue(mockApiDataSource.getUsersListCalled)
        XCTAssertTrue(mockLocalDataSource.saveCalled)
        XCTAssertEqual(mockLocalDataSource.savedUsers?.count, 2)
    }

    func test_getUsers_throwsError_whenApiFails() async throws {
        // GIVEN
        mockApiDataSource.shouldThrowError = true

        // WHEN & THEN
        await XCTAssertThrowsErrorAsync(try await self.sut.getUsers(page: 1))
    }

    func test_loadPersistedUsers_returnsUsers() async throws {
        // GIVEN
        let persistedUsers = [User.dummy(), User.dummy()]
        mockLocalDataSource.stubbedUsers = persistedUsers

        // WHEN
        let users = try await sut.loadPersistedUsers()

        // THEN
        XCTAssertEqual(users.count, 2)
        XCTAssertTrue(mockLocalDataSource.fetchAllCalled)
    }

    func test_deleteUser_callsLocalDataSource() async throws {
        // GIVEN
        let user = User.dummy()

        // WHEN
        try await sut.deleteUser(user)

        // THEN
        XCTAssertTrue(mockLocalDataSource.deleteCalled)
    }
}

