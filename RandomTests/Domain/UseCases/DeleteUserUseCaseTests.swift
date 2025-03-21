//
//  DeleteUserUseCaseTests.swift
//  RandomTests
//
//  Created by Alex Hernández on 21/3/25.
//

@testable import Random
import XCTest

final class DeleteUserUseCaseTests: XCTestCase {
    
    final class MockUserRepository: UserRepositoryType {
        var deleteUserCalled = false
        var shouldThrowError = false
        
        func deleteUser(_ user: User) async throws {
            deleteUserCalled = true
            if shouldThrowError {
                throw NSError(domain: "TestError", code: 0)
            }
        }
        
        func getUsers(page: Int) async throws -> [User] { [] }
        func loadPersistedUsers() async throws -> [User] { [] }
    }
    
    func test_execute_deletesUserSuccessfully() async throws {
        let mockRepo = MockUserRepository()
        let useCase = DeleteUserUseCase(repository: mockRepo)
        let dummyUser = User.dummy()
        
        try await useCase.execute(dummyUser)
        
        XCTAssertTrue(mockRepo.deleteUserCalled, "Expected deleteUser to be called")
    }
    
    func test_execute_throwsError_whenRepositoryFails() async {
        let mockRepo = MockUserRepository()
        mockRepo.shouldThrowError = true
        let useCase = DeleteUserUseCase(repository: mockRepo)
        let dummyUser = User.dummy()
        
        await XCTAssertThrowsErrorAsync(try await useCase.execute(dummyUser))
    }
}
