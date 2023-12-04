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
    @EnvironmentObject private var globalState: GlobalState
    @Bindable var workout: Workout
    @StateObject private var viewModel = WorkoutViewModel()
    
    var body: some View {
        ZStack {
            
            
            VStack {
                ForEach(workout.exercises) { exercise in
                    let isCurrentExercise = viewModel.currentExercise.id == exercise.id
                    
                    Text(exercise.name)
                        .font(isCurrentExercise ? .title : .body)
                        .fontWeight(isCurrentExercise ? .bold : .regular)
                }
                
                Text("\(viewModel.currentSeries) / \(viewModel.currentExercise.seriesCount)")
                Text("\(viewModel.timeRemaining)")
                
                Button {
                    viewModel.startTimer()
                } label: {
                    Text(viewModel.nextButtonText)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .navigationTitle(workout.name)
        .onAppear {
            viewModel.setup(workout: workout, dismiss: dismiss, globalState: globalState)
        }
        .onReceive(viewModel.timer) { _ in
            if viewModel.isTimerRunning {
                if viewModel.timeRemaining > 0 {
                    viewModel.timeRemaining -= 1
                } else {
                    viewModel.nextSeries()
                    viewModel.stopTimer()
                    viewModel.playSound()
                }
            }
        }
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
