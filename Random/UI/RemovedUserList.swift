//
//  RemovedUserList.swift
//  Random
//
//  Created by Alex Hernández on 2/4/25.
//

import SwiftUI

struct RemovedUserList: View {
    @Bindable var viewModel: UserListViewModel
    
    var body: some View {
        VStack {
            List(viewModel.removedUsers) { user in
                UserRowView(user: user)
            }
        }
        .navigationTitle("Removed Users")
    }
}

