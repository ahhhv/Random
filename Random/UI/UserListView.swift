//
//  UserListView.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import SwiftUI

struct UserListView: View {
    @Bindable var viewModel: UserListViewModel
    
    
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredUsers, id: \.id) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        UserRowView(user: user)
                        .swipeActions {
                            Button(role: .destructive) {
                                Task {
                                    await viewModel.deleteUser(user)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .accessibilityIdentifier("UserCell_\(user.id)")
                    .onAppear {
                        Task {
                            if user == viewModel.filteredUsers.last {
                                await viewModel.loadMore()
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: RemovedUserList(viewModel: viewModel)) {
                        Image(systemName: "xmark")
                    }
                }
            }
            .accessibilityIdentifier("UserList")
            .listStyle(.grouped)
            .searchable(text: $viewModel.searchText, prompt: "Search by name, surname or email")
            .navigationTitle("Random Users INC. (\(viewModel.filteredUsers.count))")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Error", isPresented: $viewModel.showErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
            .task {
                if viewModel.filteredUsers.isEmpty {
                    await viewModel.onAppear()
                }
            }
        }
    }
}
