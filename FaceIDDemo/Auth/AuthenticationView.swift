//
//  AuthenticationView.swift
//  FaceIDDemo
//
//  Created by Hemant kumar on 08/06/24.
//

import SwiftUI

import SwiftUI

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()

    var body: some View {
        VStack {
            if viewModel.isAuthenticated {
                WelcomeView()
            } else {
                Text("Authenticating...")
                    .onAppear {
                        viewModel.authenticate()
                    }
            }
        }
        .fullScreenCover(isPresented: $viewModel.needsAuthentication) {
            DevicePasswordView(viewModel: viewModel)
        }
    }
}

struct DevicePasswordView: View {
    @ObservedObject var viewModel: AuthenticationViewModel

    var body: some View {
        VStack {
            Text("Please authenticate with your device password")
                .padding()

            Button(action: {
                viewModel.authenticate()
            }) {
                Text("Retry Authentication")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

