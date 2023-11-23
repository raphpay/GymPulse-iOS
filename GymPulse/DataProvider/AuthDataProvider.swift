//
//  AuthDataProvider.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import Foundation
import FirebaseAuth

class AuthDataProvider: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
    
    func checkUserStatus() {
        if let authUser = Auth.auth().currentUser {
            currentUser = authUser
            isLoggedIn = true
        } else {
            currentUser = nil
            isLoggedIn = false
        }
        print("checkUserStatus",isLoggedIn, currentUser)
    }
}
