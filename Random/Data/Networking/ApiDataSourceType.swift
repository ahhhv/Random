//
//  ApiDataSourceType.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//


import Foundation

protocol ApiDataSourceType {
    func getUsersList(page: Int) async throws -> [UserDTO]
}
