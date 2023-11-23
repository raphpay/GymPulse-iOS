//
//  MainView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var authDataProvider: AuthDataProvider
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Main")
            Button {
                let result = AuthService.shared.signOut()
                switch result {
                case .success( _):
                    authDataProvider.isLoggedIn = false
                    authDataProvider.currentUser = nil
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } label: {
                Text("Sign out")
            }

        }
        .padding()
    }
}

#Preview {
    MainView()
}
