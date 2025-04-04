//
//  UserRowView.swift
//  Random
//
//  Created by Alex Hernández on 4/4/25.
//

import SwiftUI

struct UserRowView: View {
    var user: User
    
    var body: some View {
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
    }
}
