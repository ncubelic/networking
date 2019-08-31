//
//  NetworkingTests.swift
//  NetworkingTests
//
//  Created by Nikola on 31.8.2019..
//  Copyright © 2019 Nikola. All rights reserved.
//

import XCTest
@testable import Networking

class NetworkManagerTests: XCTestCase {
    
    private let dummyURL = URL(string: "https://mock.hr")!
    
    func testThatNetworkConfigurationLoadsBasePathFromInfoPlist() {
        let config = NetworkConfiguration()
        XCTAssertNotNil(config.baseURL)
        XCTAssertEqual(config.baseURL, URL(string: "https://your-base-path")!)
    }
    
    func testThatNetworkConfigurationSetCustomBasePath() {
        let config = NetworkConfiguration(baseURL: dummyURL)
        XCTAssertNotNil(config.baseURL)
        XCTAssertEqual(config.baseURL, dummyURL)
    }
    
    func testThatNetworkManagerLoadsDefaultConfigurations() {
        
        let defaultHTTPHeaders: [String: String] = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let networkManager = NetworkManager(configuration: .default)
        
        XCTAssertEqual(networkManager.configuration.requiredHTTPHeaders, defaultHTTPHeaders)
    }
    
    func testThatNetworkManagerGetFailureWhenNetworkResponseIsFailure() {
        let networkState = failureResponseState()
        
        if case NetworkResponseState.success = networkState {
            XCTFail("Response state should be 'failure', not 'success'.")
        }
    }
    
    func testThatNetworkResponseStateIsSuccessWhenStatusCodeIsIn200Range() {
        let networkState = networkResponseState(forStatus: 200)
        
        if case NetworkResponseState.failure = networkState {
            XCTFail("Response state should be 'success', not 'failure'.")
        }
    }
    
    func testThatNetworkResponseStateIsFailureWhenStatusCodeIsNotIn200Range() {
        let networkState = networkResponseState(forStatus: 500)
        
        if case NetworkResponseState.success = networkState {
            XCTFail("Response state should be 'failure' not 'success'.")
        }
    }
    
    func testThatNetworkManagerCallsSuccessWhen200IsReturnedAndExpectedResponseObjectIsDecoded() throws {
        let someData = try JSONEncoder().encode(EmptyResponse())
        
        successfulNetworkManager(withResponse: someData).apiCall(for: Resource<EmptyResponse>(path: "")) { result in
            guard let _ = try? result.get() else {
                XCTFail("Response should be in success block.")
                return
            }
        }
    }
    
    func testThatNetworkManagerCallsFailureWhen200IsReturnedAndObjectIsNotDecoded() throws {
        let undecodableData = Data(count: 100)
        let expect = expectation(description: "Object is not decoded")
        successfulNetworkManager(withResponse: undecodableData).apiCall(
        for: Resource<EmptyResponse>(path: "")) { result in
            guard let _ = try? result.get() else {
                expect.fulfill()
                return
            }
            XCTFail("Response should be in failure block.")
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func successfulNetworkManager(withResponse data: Data) -> NetworkManager {
        let response = HTTPURLResponse(url: dummyURL, statusCode: 200, httpVersion: nil, headerFields: nil)
        let config = NetworkConfiguration(session: MockURLSession(data: data, response: response, error: nil))
        let networkManager = NetworkManager(configuration: config)
        
        return networkManager
    }
    
    func networkResponseState(forStatus status: Int) -> NetworkResponseState {
        let networkManager = NetworkManager()
        let response = HTTPURLResponse(url: dummyURL, statusCode: status, httpVersion: nil, headerFields: nil)
        let networkState = networkManager.getNetworkResponseState(response: response, error: nil, data: nil)
        return networkState
    }
    
    func failureResponseState() -> NetworkResponseState {
        let networkManager = NetworkManager()
        let networkState = networkManager.getNetworkResponseState(response: nil, error: nil, data: nil)
        return networkState
    }
}

// MARK: - Mock classes

extension NetworkManagerTests {
    
    final class MockURLSession: URLSession {
        
        let data: Data?
        let response: URLResponse?
        let error: Error?
        
        init(data: Data?, response: URLResponse?, error: Error?) {
            self.data = data
            self.response = response
            self.error = error
        }
        
        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            completionHandler(data, response, error)
            return MockDataTask()
        }
    }
    
    final class MockDataTask: URLSessionDataTask {
        
        override func resume() {
        }
    }
}

