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
    
    func login(email: String, password: String) {
        // Replace with actual login logic
        if email == "test@email.com" && password == "12345678" {
            isAuthenticated = true
            isLoggedIn = true
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate with Face ID"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                    } else {
                        // Handle failed authentication
                        self.needsAuthentication = true
                    }
                }
            }
        } else {
            // Handle devices without Face ID/Touch ID
            self.needsAuthentication = true
        }
    }
}

