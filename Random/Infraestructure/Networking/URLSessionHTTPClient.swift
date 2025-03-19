//
//  URLSessionHTTPClient.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import Foundation

class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    private let requestMaker: URLSessionRequestMaker

    init(session: URLSession = .shared,
         requestMaker: URLSessionRequestMaker) {
        self.session = session
        self.requestMaker = requestMaker
    }

    func makeRequest(endpoint: Endpoint, baseUrl: String) async throws -> Data {
        guard let url = requestMaker.url(endpoint: endpoint,
                                         baseUrl: baseUrl) else {
            throw APIError.badURL
        }

        do {
            let result = try await session.data(from: url)

            guard let response = result.1 as? HTTPURLResponse else {
                throw APIError.responseError
            }

            guard response.statusCode == 200 else {
                throw APIError.responseError
            }

            return result.0
        } catch {
            throw error
        }
    }
}
