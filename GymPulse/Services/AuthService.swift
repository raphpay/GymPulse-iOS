//
//  AuthService.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import Foundation
import FirebaseAuth

protocol AuthServiceDelegate {
    func signIn(_ email: String, password: String) async throws -> Result<User, Error>
    func createUser(_ email: String, password: String) async throws -> Result<User, Error>
    func signOut() -> Result<Bool, Error>
}

class AuthenticationService {
    static let shared = AuthenticationService(service: AuthService.shared)
    var service: AuthServiceDelegate
    
    init(service: AuthServiceDelegate) {
        self.service = service
    }
}

class AuthService: AuthServiceDelegate {
    static let shared = AuthService()
    
    private init() {}
    
    func signIn(_ email: String, password: String) async throws -> Result<User, Error> {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            return .success(result.user)
        } catch let error {
            return .failure(error)
        }
    }
    
    func createUser(_ email: String, password: String) async throws -> Result<User, Error> {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            return .success(result.user)
        } catch let error {
            return .failure(error)
        }
    }
    
    func signOut() -> Result<Bool, Error> {
        do {
            try Auth.auth().signOut()
            return .success(true)
        } catch let error {
            return .failure(error)
        }
    }
}
