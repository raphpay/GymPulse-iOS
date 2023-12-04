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
        let isAvailable = await FirestoreService.shared.checkUserAvailability(email: email)
        if isAvailable {
            await FirestoreService.shared.createUser(email: email)
            let result = await AuthService.shared.createUser(email, password: password)
            handleResult(result, authDataProvider: authDataProvider)
        } else {
            let result = await AuthService.shared.signIn(email, password: password)
            handleResult(result, authDataProvider: authDataProvider)
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
