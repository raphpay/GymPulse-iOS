//
//  FirestoreService.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import Foundation
import FirebaseFirestore

protocol FirestoreServiceDelegate {
    func createUser(email: String) async throws
    func checkUserAvailability(email: String) async throws -> Bool
}

class FirestoreDatabaseService {
    static let shared = FirestoreDatabaseService(service: FirestoreService.shared)
    var service: FirestoreServiceDelegate
    
    init(service: FirestoreServiceDelegate) {
        self.service = service
    }
}

class FirestoreService: FirestoreServiceDelegate {
    static let shared = FirestoreService()
    private let database = Firestore.firestore()
    private let USERS_COLLECTION = "USERS_COLLECTION"
    
    private init() {}
    
    func createUser(email: String) async throws {
        let id = UUID().uuidString
        let data: [String: Any] = ["email": email]
        do {
            try await database.collection(USERS_COLLECTION).document(id).setData(data)
        } catch let error {
            throw error
        }
    }
    
    func checkUserAvailability(email: String) async throws -> Bool {
        var isAvailable = false
        guard !email.isEmpty else { return isAvailable }
        
        do {
            let snapshot = try await database.collection(USERS_COLLECTION).whereField("email", isEqualTo: email).getDocuments()
            isAvailable = snapshot.documents.isEmpty
        } catch let error {
            throw error
        }
        
        return isAvailable
    }
}
