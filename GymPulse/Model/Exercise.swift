//
//  Exercise.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import Foundation
import SwiftData

@Model
class Exercise: Identifiable {
    let id = UUID()
    var name: String
    var seriesCount: Int
    var repCount: Int
    var weight: Double
    
    init(name: String, seriesCount: Int, repCount: Int, weight: Double) {
        self.name = name
        self.seriesCount = seriesCount
        self.repCount = repCount
        self.weight = weight
    }
    
    static let mock = Exercise(name: "Mock", seriesCount: 0, repCount: 0, weight: 0)
}

enum ExerciseOption: String, CaseIterable {
    case classicSquat = "Classic Squat"
    case deadlift = "Deadlift"
    case benchPress = "Bench-Press"
    case barbellBackSquat = "Barbell Back Squat"
    case bodyweightSquat = "Bodyweight Squat"
    case gobletSquat = "Goblet Squat"
    case frontSquat = "Front Squat"
    case sumoSquat = "Sumo Squat"
    case conventionalDeadlift = "Conventional Deadlift"
    case romanianDeadlift = "Romanian Deadlift"
    case sumoDeadlift = "Sumo Deadlift"
    case trapBarDeadlift = "Trap Bar Deadlift"
    case singleLegDeadlift = "Single-Leg Deadlift"
    
    // Add more exercises following the same pattern
}
