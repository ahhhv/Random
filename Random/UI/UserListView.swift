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
                        HStack {
                            AsyncImage(url: URL(string: user.picture)) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(user.fullName).font(.headline)
                                    Spacer()
                                    Text(user.phone).font(.caption2).foregroundColor(.green)
                                }
                                
                                Text(user.email).font(.subheadline).foregroundColor(.gray)
                            }
                        }
                        
                        .swipeActions {
                            Button(role: .destructive) {
                                viewModel.deleteUser(user)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .onAppear {
                        Task {
                            if user == viewModel.filteredUsers.last {
                                await viewModel.loadMore()
                            }
                        }
                    }
                }
            }
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
                if viewModel.users.isEmpty {
                    await viewModel.onAppear()
                }
            }
        }
    }
}
