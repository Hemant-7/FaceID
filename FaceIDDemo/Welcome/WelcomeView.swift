//
//  WelcomeView.swift
//  FaceIDDemo
//
//  Created by Hemant kumar on 08/06/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Welcome!")
            .font(.largeTitle)
            .padding()
            .accessibilityIdentifier("WelcomeView")
    }
}

#Preview {
    WelcomeView()
}
