//
//  WorkoutViewModel.swift
//  GymPulse
//
//  Created by Raphaël Payet on 24/11/2023.
//

import Foundation
import SwiftUI
import AVFoundation

class WorkoutViewModel: ObservableObject {
    @Published var currentExerciseIndex = 0
    @Published var currentSeries = 1
    @Published var isTimerRunning = false
    @Published var timeRemaining: TimeInterval = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var player: AVAudioPlayer?
    
    var workout: Workout?
    var dismiss: DismissAction?
    var globalState: GlobalState?
    
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
    var formattedTime: String {
        var string = ""
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60

        if minutes > 0 {
            string = "\(minutes)min \(seconds)sec"
        } else {
            string = "\(seconds)sec"
        }
        return string
    }
    
    func setup(workout: Workout, dismiss: DismissAction, globalState: GlobalState) {
        self.workout = workout
        self.dismiss = dismiss
        self.timeRemaining = workout.breakDurationInS
        self.globalState = globalState
    }
    
    func nextSeries() {
        if currentSeries < currentExercise.seriesCount {
            currentSeries += 1
        } else {
            nextExercise()
        }
    }
    
    func startTimer() {
        withAnimation { self.isTimerRunning = true }
    }
    
    func stopTimer() {
        withAnimation { self.isTimerRunning = false }
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
    
    func playSound() {
        guard let ringtoneID = globalState?.ringtone.id,
              let url = Bundle.main.url(forResource: ringtoneID, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playRingtone() {
        let systemSoundID: SystemSoundID = 1013
        AudioServicesPlaySystemSound(systemSoundID)
    }
}
