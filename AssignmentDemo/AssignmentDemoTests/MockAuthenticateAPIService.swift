//
//  MockAuthenticateAPIService.swift
//  AssignmentDemoTests
//
//  Created by Subhash on 22/07/24.
//

import XCTest
@testable import AssignmentDemo

class MockAuthenticateAPIService: AuthenticationAPIProtocol {
   
    func authenticate(with credential: AuthModel, type: AuthType) async -> Result<Bool, Error> {
        
        if credential.email == "Test@gmail.com" {
            return .failure(HttpErrors.invalidRequest)
        } else {
            return .success(true)
        }
    }
}
