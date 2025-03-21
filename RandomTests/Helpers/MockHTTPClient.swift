//
//  MockHTTPClient.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

@testable import Random
import Foundation

final class MockHTTPClient: HTTPClient {
    var result: Result<Data, Error>?
    
    func makeRequest(endpoint: Endpoint, baseUrl: String) async throws -> Data {
        guard let result = result else { fatalError("MockHTTPClient result not set") }
        
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}
