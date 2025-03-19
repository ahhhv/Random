//
//  UserListView.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//


import SwiftUI

struct UserListView: View {
    @ObservedObject private var viewModel: UserListViewModel

    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
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
                                Text(user.name).font(.headline)
                                Text(user.email).font(.subheadline).foregroundColor(.gray)
                            }
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            // TO DO
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
            .navigationTitle("Random Users INC. (\(viewModel.users.count))")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
