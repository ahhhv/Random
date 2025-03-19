//
//  UserListViewModel.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//


import Foundation

class UserListViewModel: ObservableObject {
    private let getUserList: GetUserRepositoryType
    @Published var users: [User] = []
    var currentPage: Int = 1
    
    init(getUserList: GetUserRepositoryType) {
        self.getUserList = getUserList
    }

    func onAppear() {
        Task {
            do {
                let result = try await getUserList.execute(page: currentPage)
                Task { @MainActor in
                    self.users = result
                }
            } catch {
                print(error.localizedDescription)
            }
            
            
        }
    }
}
