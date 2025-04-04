//
//  UserListViewModel.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import SwiftUI

@Observable
final class UserListViewModel {
    private let loadUsersUseCase: LoadUsersUseCaseType
    private let getUsersUseCase: GetUsersUseCaseType
    private let deleteUserUseCase: DeleteUserUseCaseType
    
    var users: [User] = []
    
    private(set) var isLoading = false
    private(set) var currentPage: Int = 1
    var searchText: String = ""
    var showErrorAlert = false
    var errorMessage = ""

    var filteredUsers: [User] {
        if searchText.isEmpty {
            return users.filter { !$0.removed }
        } else {
            return users.filter { user in
                user.name.localizedCaseInsensitiveContains(searchText) ||
                user.surname.localizedCaseInsensitiveContains(searchText) ||
                user.email.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var removedUsers: [User] {
        users
            .filter({ $0.removed })
            .sorted(by: { $0.fullName < $1.fullName })
    }
    
    init(loadUsersUseCase: LoadUsersUseCaseType,
         getUsersUseCase: GetUsersUseCaseType,
         deleteUsersUseCase: DeleteUserUseCaseType) {
        self.loadUsersUseCase = loadUsersUseCase
        self.getUsersUseCase = getUsersUseCase
        self.deleteUserUseCase = deleteUsersUseCase
    }
        
    private func presentError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
    }
    
    @MainActor
    func onAppear() async {
        do {
            let localUsers = try await loadUsersUseCase.execute()
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
            let newUsers = try await getUsersUseCase.execute(page: currentPage)
            users += newUsers
            currentPage += 1
        } catch {
            presentError("❌ Error fetching more users: \(error.localizedDescription)")
        }

        isLoading = false
    }

    @MainActor
    func deleteUser(_ user: User) async {
        do {
            try await deleteUserUseCase.execute(user)
            await refreshUsers()
        } catch {
            presentError("❌ Error deleting user: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func refreshUsers() async {
        do {
            users = try await loadUsersUseCase.execute()
        } catch {
            presentError(error.localizedDescription)
        }
    }
}
