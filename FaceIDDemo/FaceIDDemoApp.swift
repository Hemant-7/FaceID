//
//  FaceIDDemoApp.swift
//  FaceIDDemo
//
//  Created by Hemant kumar on 08/06/24.
//

import SwiftUI

@main
struct FaceIDDemoApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

        var body: some Scene {
            WindowGroup {
                if isLoggedIn {
                    AuthenticationView()
                } else {
                    LoginView()
                }
            }
        }
}

struct FirstLaunchView: View {
    var body: some View {
        VStack {
            Text("First Launch")
                .font(.largeTitle)
            NavigationLink(destination: LoginView()) {
                Text("Proceed to Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
