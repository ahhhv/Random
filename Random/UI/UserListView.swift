//
//  UserListView.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import SwiftUI

struct UserListView: View {
    private var viewModel: UserListViewModel

    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users.indices, id: \.self) { index in
                    let user = viewModel.users[index]
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
                            if index == viewModel.users.count - 1 {
                                await viewModel.loadMore()
                            }
                        }
                    }
                }
            }
            .listStyle(.grouped)
            .navigationTitle("Random Users INC. (\(viewModel.users.count))")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                if viewModel.users.isEmpty {
                    await viewModel.onAppear()
                }
            }
        }
    }
}
