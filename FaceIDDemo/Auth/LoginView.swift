//
//  LoginView.swift
//  FaceIDDemo
//
//  Created by Hemant kumar on 08/06/24.
//

import SwiftUI

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            Button(action: {
                viewModel.login(email: email, password: password)
            }) {
                Text("Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .fullScreenCover(isPresented: $viewModel.isAuthenticated) {
            WelcomeView()
        }
    }
}




#Preview {
    LoginView()
}
