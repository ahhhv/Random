//
//  UserListFactoryTests.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//


import XCTest
@testable import Random

final class UserListFactoryTests: XCTestCase {

    @MainActor
    func test_createUserListView_returnsValidViewWithInjectedViewModel() {
        // Arrange
        let factory = UserListFactory()
        
        // Act
        let view = factory.createUserListView()
        
        // Assert
        XCTAssertNotNil(view, "Expected non-nil UserListView")
    }
}
