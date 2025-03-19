//
//  RandomApp.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import SwiftUI

@main
struct RandomApp: App {
    var body: some Scene {
        WindowGroup {
            UserListFactory.create()
        }
    }
}
