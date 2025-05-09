//
//  MockURLProtocol.swift
//  Random
//
//  Created by Alex Hernández on 21/3/25.
//

import XCTest

class MockURLProtocol: URLProtocol {
	override class func canInit(with _: URLRequest) -> Bool {
		return true
	}

	override class func canonicalRequest(for request: URLRequest) -> URLRequest {
		return request
	}

	static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

	override func startLoading() {
		guard let handler = MockURLProtocol.requestHandler else {
			XCTFail("No request handler provided")
			return
		}

		do {
			let (response, data) = try handler(request)

			client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
			client?.urlProtocol(self, didLoad: data)
			client?.urlProtocolDidFinishLoading(self)
		} catch {
			XCTFail("Error handling request: \(error)")
		}
	}

	override func stopLoading() {}
}
