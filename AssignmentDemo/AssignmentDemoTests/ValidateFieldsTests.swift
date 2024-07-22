//
//  ValidateFieldsTests.swift
//  AssignmentDemoTests
//
//  Created by Subhash on 22/07/24.
//

import XCTest
@testable import AssignmentDemo

class ValidateFieldsTests: XCTestCase {

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ValidateFields_email_password_valid() {
        let result = ValidateFields.validateUserField(AuthModel(email: "test@gmail.com", password: "test"))
        XCTAssertNil(result)
    }
    
    func test_ValidateFields_email_password_invalid() {
        let result = ValidateFields.validateUserField(AuthModel(email: "", password: ""))
        do {
            let validateMessage = try XCTUnwrap(result)
            XCTAssertNotNil(validateMessage)
            XCTAssertEqual(validateMessage, AppConstants.emailPassValidateMsg)
        } catch {
            XCTFail()
        }
    }
    
    func test_ValidateFields_email_invalid() {
        let result = ValidateFields.validateUserField(AuthModel(email: "", password: "test"))
        do {
            let validateMessage = try XCTUnwrap(result)
            XCTAssertNotNil(validateMessage)
            XCTAssertEqual(validateMessage, AppConstants.emailValidateMsg)
        } catch {
            XCTFail()
        }
    }
    
    func test_ValidateFields_password_invalid() {
        let result = ValidateFields.validateUserField(AuthModel(email: "Test@gmail.com", password: ""))
        do {
            let validateMessage = try XCTUnwrap(result)
            XCTAssertNotNil(validateMessage)
            XCTAssertEqual(validateMessage, AppConstants.passValidateMsg)
        } catch {
            XCTFail()
        }
    }
}
