//
//  InspectionRouterTests.swift
//  AssignmentDemoTests
//
//  Created by Subhash on 22/07/24.
//

import XCTest
@testable import AssignmentDemo

class InspectionRouterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_InspectionRouter_start_Inspection_parameter() {
        let result = InspectionRouter.startInspection
        XCTAssertNotNil(result)
        
        XCTAssertEqual("http://127.0.0.1:5001/api/inspections/start", result.urlString)
        XCTAssertEqual(result.httpMethod, RequestMethod.get)
    }
    
    func test_InspectionRouter_submit_Inspection_parameter() {
        let result = InspectionRouter.submitInspection
        XCTAssertNotNil(result)
        
        XCTAssertEqual("http://127.0.0.1:5001/api/inspections/submit", result.urlString)
        XCTAssertEqual(result.httpMethod, RequestMethod.post)
    }

}
