//
//  AddExerciseViewModel.swift
//  GymPulse
//
//  Created by Raphaël Payet on 24/11/2023.
//

import SwiftUI

class AddExerciseViewModel: ObservableObject {
    @Published var selectedExerciseOption = ExerciseOption.classicSquat
    @Published var repsCount = 2
    @Published var seriesCount = 3
    @Published var weight = 50.0
    
    let minimumWeight = 0.0
    let maximumWeight = 200.0
    
    func saveWorkout(workout: Workout) {
        let exercise = Exercise(name: selectedExerciseOption.rawValue, seriesCount: seriesCount, repCount: repsCount, weight: weight)
        workout.exercises.append(exercise)
    }
}
