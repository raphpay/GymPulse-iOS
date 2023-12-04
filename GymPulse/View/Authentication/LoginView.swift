//
//  LoginView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var authDataProvider: AuthDataProvider
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            Image(Assets.appBackground)
                .resizable()
                .ignoresSafeArea()
                .opacity(0.6)
            
            VStack {
                Image(Assets.logo)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 50)
                Spacer()
                
                TextField("Email", text: $viewModel.email)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)
                
                Spacer()
                
                Button {
                    Task {
                        await viewModel.login(authDataProvider: authDataProvider)
                    }
                } label: {
                    Text("Log in")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
