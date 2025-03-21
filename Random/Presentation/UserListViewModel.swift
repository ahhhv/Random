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

    init(userRepository: UserRepositoryType) {
        self.userRepository = userRepository
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
            print("❌ Error cargando usuarios: \(error.localizedDescription)")
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
            isLoading = false
        } catch {
            print(error.localizedDescription)
            isLoading = false
        }
    }

    @MainActor
    func deleteUser(_ user: User) {
        Task {
            do {
                try await userRepository.deleteUser(user)
                users.removeAll { $0.id == user.id }
            } catch {
                print("❌ Error al borrar usuario: \(error.localizedDescription)")
            }
        }
    }

}
