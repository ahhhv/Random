//
//  APIUserDataSourceTests.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//


import XCTest
@testable import Random

final class APIUserDataSourceTests: XCTestCase {
    
    private var mockHttpClient: MockHTTPClient!
    private var dataSource: APIUserDataSource!
    
    override func setUp() {
        super.setUp()
        mockHttpClient = MockHTTPClient()
        dataSource = APIUserDataSource(httpClient: mockHttpClient)
    }
    
    override func tearDown() {
        mockHttpClient = nil
        dataSource = nil
        super.tearDown()
    }

    func test_getUsersList_returnsUsers_whenResponseIsValid() async throws {
        // GIVEN
        let mockDTO = UserDTO.dummy()
        let response = RandomUserResponse(results: [mockDTO])
        let jsonData = try JSONEncoder().encode(response)
        
        mockHttpClient.result = .success(jsonData)
        
        // WHEN
        let users = try await dataSource.getUsersList(page: 1)
        
        // THEN
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.email, mockDTO.email)
    }
    
    func test_getUsersList_throwsParsingError_whenResponseIsInvalid() async {
        // GIVEN
        let invalidJSON = Data()
        mockHttpClient.result = .success(invalidJSON)
        
        // WHEN - THEN
        await XCTAssertThrowsErrorAsync(try await self.dataSource.getUsersList(page: 1)) { error in
            XCTAssertEqual(error as? APIError, APIError.parsingError)
        }
    }

    func test_getUsersList_throwsError_whenHttpClientFails() async {
        // GIVEN
        mockHttpClient.result = .failure(APIError.responseError)
        
        // WHEN - THEN
        await XCTAssertThrowsErrorAsync(try await self.dataSource.getUsersList(page: 1)) { error in
            XCTAssertEqual(error as? APIError, APIError.responseError)
        }
    }
}
