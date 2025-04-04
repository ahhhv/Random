//
//  UserListViewModelTests.swift
//  RandomTests
//
//  Created by Alex Hernández on 2/4/25.
//

@testable import Random
import XCTest

final class UserListViewModelTests: XCTestCase {
    var loadUsers: MockLoadUsersUseCase!
    var getUsers: MockGetUsersUseCase!
    var deleteUsers: MockDeleteUserUseCase!
    var sut: UserListViewModel!
    
    override func setUp() {
        super.setUp()
        loadUsers = MockLoadUsersUseCase()
        getUsers = MockGetUsersUseCase()
        deleteUsers = MockDeleteUserUseCase()
        
        sut = UserListViewModel(
            loadUsersUseCase: loadUsers,
            getUsersUseCase: getUsers,
            deleteUsersUseCase: deleteUsers
        )
    }
    
    func test_loadsUsersFromLocal() async {
        // Given
        let user = Random.User(id: "1", name: "Alex", surname: "Hernandez", email: "test@example.com", gender: "male", street: "Fake street", phone: "123456", city: "Barcelona", state: "Spain", picture: "", registered: "", removed: false)
        loadUsers.result = .success([user])
        
        // When
        
        await sut.onAppear()
        
        // Then
        XCTAssertEqual(sut.users.count, 1)
        XCTAssertEqual(sut.users.first?.name, "Alex")
    }
    
    func test_deleteUser_callsDeleteUserUseCase() async {
        // Given
        let user = Random.User(id: "1", name: "Alex", surname: "Hernandez", email: "test@example.com", gender: "male", street: "Fake street", phone: "123456", city: "Barcelona", state: "Spain", picture: "", registered: "", removed: false)
        sut.users = [user]
        
        // When
        await sut.deleteUser(user)
        
        // Then
        XCTAssertTrue(deleteUsers.didDeleteUser)
        XCTAssertTrue(sut.users.isEmpty)
        XCTAssertTrue(sut.removedUsers.isEmpty)
    }
}


class MockLoadUsersUseCase: LoadUsersUseCaseType {
    var result: Result<[Random.User], Error> = .success([])
    func execute() async throws -> [Random.User] {
        switch result {
        case .success(let users): return users
        case .failure(let error): throw error
        }
    }
}

class MockGetUsersUseCase: GetUsersUseCaseType {
    var result: Result<[Random.User], Error> = .success([])
    
    func execute(page: Int) async throws -> [User] {
        switch result {
        case .success(let users): return users
        case .failure(let error): throw error
        }
    }
}

class MockDeleteUserUseCase: DeleteUserUseCaseType {
    var didDeleteUser = false
    
    func execute(_ user: Random.User) async throws {
        didDeleteUser = true
    }
}
