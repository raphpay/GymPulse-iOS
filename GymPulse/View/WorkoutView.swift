//
//  WorkoutView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI
import SwiftData

struct WorkoutView: View {
    
    @Environment(\.dismiss) var dismiss
    @Bindable var workout: Workout
    @State private var currentExerciseIndex = 0
    @State private var currentSeries = 1
    
    var currentExercise: Exercise {
        workout.exercises[currentExerciseIndex]
    }
    var nextButtonText: String {
        currentSeries < currentExercise.seriesCount ? "Next Series" : (
            currentExerciseIndex + 1 < workout.exercises.count ? "Next Exercise" : "Finish Workout"
        )
    }
    
    var body: some View {
        VStack {
            ForEach(workout.exercises) { exercise in
                let isCurrentExercise = currentExercise.id == exercise.id
                
                Text(exercise.name)
                    .font(isCurrentExercise ? .title : .body)
                    .fontWeight(isCurrentExercise ? .bold : .regular)
            }
            
            Text("\(currentSeries) / \(currentExercise.seriesCount)")
            
            Button {
                nextSeries()
            } label: {
                Text(nextButtonText)
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle(workout.name)
    }
    
    func nextSeries() {
        if currentSeries < currentExercise.seriesCount {
            currentSeries += 1
        } else {
            nextExercise()
        }
    }
    
    func nextExercise() {
        if currentExerciseIndex + 1 < workout.exercises.count {
            withAnimation {
                self.currentExerciseIndex += 1
                self.currentSeries = 1
            }
        } else {
            finishWorkout()
        }
    }
    
    func finishWorkout() {
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        let example = Workout(ownerID: "TestID", name: "Workout Example", breakDurationInS: 150)
        return WorkoutView(workout: example)
                                    .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
