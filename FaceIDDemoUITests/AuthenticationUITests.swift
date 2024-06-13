//
//  AuthenticationUITests.swift
//  FaceIDDemoUITests
//
//  Created by Hemant kumar on 12/06/24.
//

import XCTest

class AuthenticationUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchEnvironment["UITest"] = "1"
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.waitForExistence(timeout: 5))
        emailTextField.tap()
        emailTextField.typeText("test@email.com")
        
        let passwordSecureField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordSecureField.waitForExistence(timeout: 5))
        passwordSecureField.tap()
        passwordSecureField.typeText("12345678")
        
        app.buttons["Login"].tap()
   
        // Ensure that the app proceeds to the welcome view after successful authentication simulation
        let welcomeView = app.staticTexts["Welcome!"]
        XCTAssertTrue(welcomeView.exists)
    }
}

