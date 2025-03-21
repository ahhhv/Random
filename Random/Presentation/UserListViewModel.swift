//
//  UserListViewModel.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import SwiftUI

@Observable
final class UserListViewModel {
    private let userRepository: UserRepositoryType
    private(set) var users: [User] = []
    private(set) var isLoading = false
    private(set) var currentPage: Int = 1
    var searchText: String = ""
    var showErrorAlert = false
    var errorMessage = ""

    var filteredUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { user in
                user.name.localizedCaseInsensitiveContains(searchText) ||
                user.surname.localizedCaseInsensitiveContains(searchText) ||
                user.email.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    init(userRepository: UserRepositoryType) {
        self.userRepository = userRepository
    }
        
    private func presentError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
    }
    
    @MainActor
    func onAppear() async {
        do {
            let localUsers = try await userRepository.loadPersistedUsers()
            if localUsers.isEmpty {
                await loadMore()
            } else {
                print("📂 Cargando usuarios desde la base de datos local")
                users = localUsers
            }
        } catch {
            presentError("❌ Error loading local users: \(error.localizedDescription)")
        }
    }

    @MainActor
    func loadMore() async {
        guard !isLoading else { return }
        isLoading = true

        do {
            let newUsers = try await userRepository.getUsers(page: currentPage)
            
            users += newUsers
            currentPage += 1
        } catch {
            presentError("❌ Error fetching more users: \(error.localizedDescription)")
        }

        isLoading = false
    }

    @MainActor
    func deleteUser(_ user: User) {
        Task {
            do {
                try await userRepository.deleteUser(user)
                users.removeAll { $0.id == user.id }
            } catch {
                presentError("❌ Error deleting user: \(error.localizedDescription)")
            }
        }
    }

}
