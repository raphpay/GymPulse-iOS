//
//  GymPulseApp.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI
import SwiftData
import FirebaseAuth

@main
struct GymPulseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject private var authDataProvider = AuthDataProvider()
    @ObservedObject private var globalState = GlobalState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Workout.self)
                .environmentObject(authDataProvider)
                .environmentObject(globalState)
                .onAppear {
                    authDataProvider.checkUserStatus()
                }
        }
    }
}
