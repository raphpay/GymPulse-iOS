//
//  CreateWorkoutViewModel.swift
//  GymPulse
//
//  Created by Raphaël Payet on 24/11/2023.
//

import Foundation

class CreateWorkoutViewModel: ObservableObject {
    @Published var minutes = 0
    @Published var seconds = 0
    @Published var showExerciseAlert = false
    @Published var alertWidth: CGFloat = 0.0
    @Published var alertHeight: CGFloat = 0.0
    
    func updatePickersFromWorkoutDuration(workout: Workout) {
        let totalSeconds = Int(workout.breakDurationInS)
        minutes = totalSeconds / 60
        seconds = totalSeconds % 60
    }
    
    func updateWorkoutDuration(workout: Workout) {
        let totalSeconds = minutes * 60 + seconds
        workout.breakDurationInS = Double(totalSeconds)
    }
}
