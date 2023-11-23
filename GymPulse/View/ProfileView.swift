//
//  ProfileView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var authDataProvider: AuthDataProvider
    
    var body: some View {
        Button {
            let result = AuthService.shared.signOut()
            switch result {
            case .success( _):
                authDataProvider.isLoggedIn = false
                authDataProvider.currentUser = nil
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        } label: {
            Text("Log out")
        }
    }
}

#Preview {
    ProfileView()
}
