//
//  GetUsersUseCaseTests.swift
//  RandomTests
//
//  Created by Alex Hernández on 21/3/25.
//

import XCTest
@testable import Random

final class GetUsersUseCaseTests: XCTestCase {
    final class MockSuccessRepository: UserRepositoryType {
        func getUsers(page: Int) async throws -> [User] {
            return [
                User(id: "1", name: "Test", surname: "User", email: "test@example.com", gender: "", street: "", phone: "", city: "", state: "", picture: "", registered: "", removed: false)
            ]
        }
        
        func loadPersistedUsers() async throws -> [User] { [] }
        func deleteUser(_ user: User) async throws {}
    }
    
    final class MockFailureRepository: UserRepositoryType {
        func getUsers(page: Int) async throws -> [User] {
            throw NSError(domain: "TestError", code: 123, userInfo: nil)
        }

        func loadPersistedUsers() async throws -> [User] { [] }
        func deleteUser(_ user: User) async throws {}
    }
    
    func test_execute_returnsUsers_whenRepositorySucceeds() async throws {
        let useCase = GetUsersUseCase(repository: MockSuccessRepository())
        
        let result = try await useCase.execute(page: 1)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.email, "test@example.com")
    }
    
    func test_execute_throwsError_whenRepositoryFails() async {
        let useCase = GetUsersUseCase(repository: MockFailureRepository())
        
        await XCTAssertThrowsErrorAsync(try await useCase.execute(page: 1))
    }
}
