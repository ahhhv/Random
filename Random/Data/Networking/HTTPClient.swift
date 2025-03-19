//
//  HTTPClient.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//


import Foundation

protocol HTTPClient {
    func makeRequest(endpoint: Endpoint, baseUrl: String) async throws -> Data
}
