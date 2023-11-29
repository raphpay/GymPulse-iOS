//
//  FirestoreServiceTests.swift
//  GymPulseTests
//
//  Created by Raphaël Payet on 24/11/2023.
//

import Foundation
import XCTest
@testable import GymPulse


final class FirestoreServiceTests: XCTestCase {
    var sut: FirestoreServiceDelegate!
    
    override func setUp() {
        super.setUp()
        // Set up code here
        sut = FirestoreService.shared
    }
    
    override func tearDown() {
        // Tear down code here
        sut = nil
        super.tearDown()
    }

    func testCreateUser() async throws {
        // Given
        let email = "test@example.com"

        // When
        do {
            try await sut.createUser(email: email)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }

        // Then
        // You might want to check the Firestore database to ensure the user is created
        // Add appropriate assertions or expectations here
    }

    func testCheckUserIsAvailable() async throws {
        // Given
        let availableEmail = "available@example.com"

        // When
        do {
            let isAvailable = try await sut.checkUserAvailability(email: availableEmail)
            XCTAssertTrue(isAvailable, "User should be available")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testCheckUserIsUnavailable() async throws {
        // Given
        let unavailableEmail = "test@example.com"

        do {
            let isAvailable = try await sut.checkUserAvailability(email: unavailableEmail)
            XCTAssertFalse(isAvailable, "User should not be available")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
