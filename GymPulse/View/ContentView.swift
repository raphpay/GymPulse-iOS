//
//  ContentView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject private var authDataProvider: AuthDataProvider
    
    var body: some View {
        if authDataProvider.isLoggedIn {
            MainView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    ContentView()
}
