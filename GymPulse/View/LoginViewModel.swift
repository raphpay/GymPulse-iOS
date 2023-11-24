//
//  LoginViewModel.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login(authDataProvider: AuthDataProvider) async {
        let firestoreService = FirestoreDatabaseService.shared.service
        let authService = AuthenticationService.shared.service
        do {
            let isAvailable = try await firestoreService.checkUserAvailability(email: email)
            if isAvailable {
                try await firestoreService.createUser(email: email)
                let result = try await authService.createUser(email, password: password)
                handleResult(result, authDataProvider: authDataProvider)
            } else {
                let result = try await authService.signIn(email, password: password)
                handleResult(result, authDataProvider: authDataProvider)
            }
        } catch let error {
            print(error)
        }
    }
    
    private func handleResult(_ result: Result<User, Error>, authDataProvider: AuthDataProvider) {
        switch result {
        case .success(let user):
            DispatchQueue.main.async {
                authDataProvider.isLoggedIn = true
                authDataProvider.currentUser = user
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
