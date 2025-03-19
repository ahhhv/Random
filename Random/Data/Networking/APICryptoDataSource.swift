//
//  APICryptoDataSource.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//


import Foundation

class APIUserDataSource: ApiDataSourceType {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getUsersList(page: Int) async throws -> [UserDTO] {
        let endpoint = Endpoint(path: "api",
                                queryParameters: ["page": page, "results": "5"])
        let result = try await httpClient.makeRequest(endpoint: endpoint,
                                                  baseUrl: "https://randomuser.me/")
        
        guard let list = try? JSONDecoder().decode(RandomUserResponse.self,
                                                         from: result) else {
            throw APIError.parsingError
        }

        return list.results
    }
}

enum APIError: String, Error {
    case decodingFailed
    case parsingError
    case badURL
    case responseError
}
