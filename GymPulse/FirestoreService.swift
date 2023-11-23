//
//  FirestoreService.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import Foundation
import FirebaseFirestore

class FirestoreService {
    static let shared = FirestoreService()
    private let database = Firestore.firestore()
    private let USERS_COLLECTION = "USERS_COLLECTION"
    
    private init() {}
    
    func createUser(email: String) async {
        let id = UUID().uuidString
        let data: [String: Any] = ["email": email]
        do {
            try await database.collection(USERS_COLLECTION).document(id).setData(data)
        } catch let error {
            print(error)
        }
    }
    
    func checkUserAvailability(email: String) async -> Bool {
        var isAvailable = false
        guard !email.isEmpty else { return isAvailable }
        
        do {
            let snapshot = try await database.collection(USERS_COLLECTION).whereField("email", isEqualTo: email).getDocuments()
            isAvailable = snapshot.documents.isEmpty
        } catch let error {
            print(error)
        }
        
        return isAvailable
    }
}
