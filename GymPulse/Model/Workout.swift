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
    var name: String
    var breakDurationInS: Double
    @Relationship(deleteRule: .cascade) var exercises = [Exercise]()
    
    init(name: String, breakDurationInS: Double, exercises: [Exercise] = [Exercise]()) {
        self.name = name
        self.breakDurationInS = breakDurationInS
        self.exercises = exercises
    }
}
