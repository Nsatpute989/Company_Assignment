//
//  AuthRouterTests.swift
//  AssignmentDemoTests
//
//  Created by Subhash on 22/07/24.
//

import XCTest
@testable import AssignmentDemo

class AuthRouterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AuthRouter_login_parameter() {
        let result = AuthRouter.login(request: AuthModel(email: "Test@gmail.com", password: "test"))
        XCTAssertNotNil(result)
        
        XCTAssertEqual("http://127.0.0.1:5001/api/login", result.urlString)
        XCTAssertEqual(result.httpMethod, RequestMethod.post)
    }
    
    func test_AuthRouter_register_parameter() {
        let result = AuthRouter.register(request: AuthModel(email: "Test@gmail.com", password: "test"))
        XCTAssertNotNil(result)
        
        XCTAssertEqual("http://127.0.0.1:5001/api/register", result.urlString)
        XCTAssertEqual(result.httpMethod, RequestMethod.post)
    }

}
