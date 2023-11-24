//
//  Workout.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import Foundation
import SwiftData

@Model
class Workout: Identifiable {
    let id = UUID()
    var ownerID: String
    var name: String
    var breakDurationInS: Double
    @Relationship(deleteRule: .cascade) var exercises = [Exercise]()
    
    init(ownerID: String, name: String, breakDurationInS: Double, exercises: [Exercise] = [Exercise]()) {
        self.ownerID = ownerID
        self.name = name
        self.breakDurationInS = breakDurationInS
        self.exercises = exercises
    }
}
