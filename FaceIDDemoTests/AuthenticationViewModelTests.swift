//
//  AuthenticationViewModelTests.swift
//  FaceIDDemoTests
//
//  Created by Hemant kumar on 12/06/24.
//

import XCTest
@testable import FaceIDDemo
import LocalAuthentication

class AuthenticationViewModelTests: XCTestCase {
    
    var viewModel: AuthenticationViewModel!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        viewModel = AuthenticationViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testLoginSuccess() {
        viewModel.login(email: "test@email.com", password: "12345678")
        XCTAssertTrue(viewModel.isAuthenticated)
        XCTAssertTrue(viewModel.isLoggedIn)
    }

    func testLoginFailure() {
        viewModel.login(email: "wrong@email.com", password: "wrongpassword")
        XCTAssertFalse(viewModel.isAuthenticated)
        XCTAssertFalse(viewModel.isLoggedIn)
    }

    func testAuthenticateSuccess() {
        let mockContext = MockLAContext()
        mockContext.canEvaluate = true
        mockContext.shouldSucceed = true
        
        viewModel = AuthenticationViewModel(contextProvider: { mockContext })

        let expectation = self.expectation(description: "Authentication Success")

        viewModel.authenticate()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.isAuthenticated)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }

    func testAuthenticateFailure() {
        let mockContext = MockLAContext()
        mockContext.canEvaluate = true
        mockContext.shouldSucceed = false
        
        viewModel = AuthenticationViewModel(contextProvider: { mockContext })

        let expectation = self.expectation(description: "Authentication Failure")

        viewModel.authenticate()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.viewModel.needsAuthentication)
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5)
    }
}

class MockLAContext: LAContext {
    var canEvaluate = false
    var shouldSucceed = false

    override func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool {
        return canEvaluate
    }

    override func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void) {
        reply(shouldSucceed, shouldSucceed ? nil : NSError(domain: "com.example.error", code: -1, userInfo: nil))
    }
}
