//
//  UserDetailView.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 16) {
            AsyncImage(url: URL(string: user.picture)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            
            Text(user.name)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                
            Text(user.email)
                .font(.footnote)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 8) {
                DetailRow(icon: "phone.fill", text: user.phone)
                DetailRow(icon: "person.fill", text: "Gender: \(user.gender.capitalized)")
                DetailRow(icon: "house.fill", text: user.street)
                DetailRow(icon: "calendar", text: "Registered: \(user.registered)")
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

struct DetailRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
        }
    }
}


#Preview {
    UserDetailView(
        user: .init(
            id: "1",
            name: "John Doe",
            surname: "Smith",
            email: "johndoe@example.com",
            gender: "male",
            street: "123 Main St",
            phone: "123-456-7890",
            city: "New York",
            state: "NY",
            picture: "https://randomuser.me/api/portraits/men/69.jpg",
            registered: "2024-01-01T12:34:56Z"
        )
    )
}
