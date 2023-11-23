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
}
