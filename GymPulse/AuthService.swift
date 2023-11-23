//
//  AuthService.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import Foundation
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    func signIn(_ email: String, password: String) async -> Result<User, Error> {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return .success(result.user)
        } catch let error {
            return .failure(error)
        }
    }
    
    func createUser(_ email: String, password: String) async -> Result<User, Error> {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            return .success(result.user)
        } catch let error {
            return .failure(error)
        }
    }
}
