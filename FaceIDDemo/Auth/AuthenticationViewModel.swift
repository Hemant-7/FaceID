//
//  AuthenticationViewModel.swift
//  FaceIDDemo
//
//  Created by Hemant kumar on 08/06/24.
//

import Foundation
import LocalAuthentication
import SwiftUI

class AuthenticationViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var needsAuthentication = false
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    private let contextProvider: () -> LAContext

    init(contextProvider: @escaping () -> LAContext = { LAContext() }) {
        self.contextProvider = contextProvider
    }

    func login(email: String, password: String) {
        if email == "test@email.com" && password == "12345678" {
            isAuthenticated = true
            isLoggedIn = true
        } else {
            isAuthenticated = false
            isLoggedIn = false
        }
    }

    func authenticate() {
        if ProcessInfo.processInfo.environment["UITest"] == "1" {
            // Bypass authentication for UI tests
            DispatchQueue.main.async {
                self.isAuthenticated = true
            }
            return
        }
        
        let context = contextProvider()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate with Face ID"

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                    } else {
                        self.needsAuthentication = true
                    }
                }
            }
        } else {
            self.needsAuthentication = true
        }
    }
}
