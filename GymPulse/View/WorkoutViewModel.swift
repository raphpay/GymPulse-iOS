//
//  WorkoutViewModel.swift
//  GymPulse
//
//  Created by Raphaël Payet on 24/11/2023.
//

import SwiftUI

class WorkoutViewModel: ObservableObject {
    @Published var currentExerciseIndex = 0
    @Published var currentSeries = 1
    @Published var isTimerRunning = false
    @Published var timeRemaining: TimeInterval = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var workout: Workout?
    var dismiss: DismissAction?
    
    var currentExercise: Exercise {
        guard let workout = workout else { return Exercise.mock }
        return workout.exercises[currentExerciseIndex]
    }
    var nextButtonText: String {
        guard let workout = workout else { return "" }
        return currentSeries < currentExercise.seriesCount ? "Next Series" : (
            currentExerciseIndex + 1 < workout.exercises.count ? "Next Exercise" : "Finish Workout"
        )
    }
    
    func setup(workout: Workout, dismiss: DismissAction) {
        self.workout = workout
        self.dismiss = dismiss
        self.timeRemaining = workout.breakDurationInS
    }
    
    func nextSeries() {
        if currentSeries < currentExercise.seriesCount {
            currentSeries += 1
        } else {
            nextExercise()
        }
    }
    
    func startTimer() {
        isTimerRunning = true
    }
    
    func stopTimer() {
        isTimerRunning = false
        guard let workout = workout else { return }
        timeRemaining = workout.breakDurationInS
    }
    
    private func nextExercise() {
        guard let workout = workout else { return }
        if currentExerciseIndex + 1 < workout.exercises.count {
            withAnimation {
                self.currentExerciseIndex += 1
                self.currentSeries = 1
            }
        } else {
            finishWorkout()
        }
    }
    
    private func finishWorkout() {
        dismiss?()
    }
}
