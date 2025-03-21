//
//  LoadUsersUseCaseTests.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

@testable import Random
import XCTest
import Foundation

final class LoadUsersUseCaseTests: XCTestCase {
    
    final class MockUserRepository: UserRepositoryType {
        var usersToReturn: [User] = []
        var shouldThrowError = false

        func loadPersistedUsers() async throws -> [User] {
            if shouldThrowError {
                throw NSError(domain: "MockError", code: -1)
            }
            return usersToReturn
        }

        func getUsers(page: Int) async throws -> [User] { [] }
        func deleteUser(_ user: User) async throws {}
    }

    func test_execute_returnsUsersFromRepository() async throws {
        // Given
        let mockRepository = MockUserRepository()
        let expectedUsers = [
            User(
                id: "1",
                name: "Alex",
                surname: "Hernández",
                email: "alex@example.com",
                gender: "male",
                street: "Calle Falsa 123",
                phone: "123456789",
                city: "Madrid",
                state: "Madrid",
                picture: "",
                registered: "",
                removed: false
            )
        ]
        mockRepository.usersToReturn = expectedUsers
        let useCase = LoadUsersUseCase(repository: mockRepository)

        // When
        let result = try await useCase.execute()

        // Then
        XCTAssertEqual(result.count, expectedUsers.count)
        XCTAssertEqual(result.first?.name, "Alex")
    }

    func test_execute_throwsError_whenRepositoryFails() async {
        let mockRepository = MockUserRepository()
        mockRepository.shouldThrowError = true
        let useCase = LoadUsersUseCase(repository: mockRepository)

        await XCTAssertThrowsErrorAsync(try await useCase.execute())
    }
}

extension XCTestCase {
    func XCTAssertThrowsErrorAsync<T>(
        _ expression: @autoclosure @escaping () async throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line,
        _ errorHandler: (Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail("Expected error but got success", file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}
