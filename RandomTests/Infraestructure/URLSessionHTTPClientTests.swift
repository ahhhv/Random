//
//  URLSessionHTTPClientTests.swift
//  RandomTests
//
//  Created by Alex Hernández on 21/3/25.
//

import XCTest
@testable import Random

final class URLSessionHTTPClientTests: XCTestCase {
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: config)
    }()
    
    override class func tearDown() {
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }
    
    class URLSessionRequestMakerMock: URLSessionRequestMaker {
        override func url(endpoint: Endpoint, baseUrl: String) -> URL? {
            return nil
        }
    }

    func test_makeRequest_successfulGET_returnsData() async throws {
        // Given
        let baseUrl = "https://example.com"
        let endpoint = Endpoint(path: "/test", queryParameters: ["param": "value"])
        let expectedData = Data("OK".utf8)

        let expectedURL = URL(string: "\(baseUrl)/test?param=value")!

        MockURLProtocol.requestHandler = { request in
            XCTAssertEqual(request.url?.absoluteString, expectedURL.absoluteString)
            XCTAssertEqual(request.httpMethod, "GET")

            let response = HTTPURLResponse(url: expectedURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, expectedData)
        }

        let requestMaker = URLSessionRequestMaker()
        let client = URLSessionHTTPClient(session: session, requestMaker: requestMaker)

        // When
        let data = try await client.makeRequest(endpoint: endpoint, baseUrl: baseUrl)

        // Then
        XCTAssertEqual(data, expectedData)
    }

    func test_makeRequest_invalidURL_throwsBadURLError() async throws {
        // Given
        let badRequestMaker = URLSessionRequestMakerMock()
        let client = URLSessionHTTPClient(session: session, requestMaker: badRequestMaker)

        let endpoint = Endpoint(path: "", queryParameters: [:])
        let baseUrl = "bad url"

        // Then
        await XCTAssertThrowsErrorAsync(try await client.makeRequest(endpoint: endpoint, baseUrl: baseUrl)) { error in
            XCTAssertEqual(error as? APIError, APIError.badURL)
        }
    }

    func test_makeRequest_non200StatusCode_throwsResponseError() async throws {
        // Given
        let baseUrl = "https://example.com"
        let endpoint = Endpoint(path: "/fail", queryParameters: [:])
        let expectedURL = URL(string: baseUrl + "/fail")!

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: expectedURL, statusCode: 404, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        let requestMaker = URLSessionRequestMaker()
        let client = URLSessionHTTPClient(session: session, requestMaker: requestMaker)

        // Then
        await XCTAssertThrowsErrorAsync(try await client.makeRequest(endpoint: endpoint, baseUrl: baseUrl)) { error in
            XCTAssertEqual(error as? APIError, APIError.responseError)
        }
    }
}
