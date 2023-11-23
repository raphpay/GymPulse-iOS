//
//  GymPulseApp.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI
import FirebaseAuth

@main
struct GymPulseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject private var authDataProvider = AuthDataProvider()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authDataProvider)
                .onAppear {
                    authDataProvider.checkUserStatus()
                }
        }
    }
}
