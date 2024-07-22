//
//  AuthenticationAPIServiceTest.swift
//  AssignmentDemoTests
//
//  Created by Subhash on 22/07/24.
//

import XCTest
@testable import AssignmentDemo

class AuthenticationAPIServiceTest: XCTestCase {

    var mockAPIService: MockAuthenticateAPIService!
    override func setUpWithError() throws {
        mockAPIService = MockAuthenticateAPIService()
    }

    override func tearDownWithError() throws {
        mockAPIService = nil
    }

    func test_AuthenticationAPIService_authentication_success() async {
        let result = await mockAPIService.authenticate(with: AuthModel(email: "NewTest@gmail.com", password: "test"), type: .login)
        XCTAssertNotNil(result)
        switch result {
        case let .success(value):
            XCTAssertTrue(value)
        case .failure:
            XCTFail()
        }
    }
    
    func test_AuthenticationAPIService_authentication_failure() async {
        let result = await mockAPIService.authenticate(with: AuthModel(email: "Test@gmail.com", password: "test"), type: .login)
        XCTAssertNotNil(result)
        switch result {
        case .success:
            XCTFail()
        case let .failure(error):
            XCTAssertNotNil(error)
        }
    }
}
