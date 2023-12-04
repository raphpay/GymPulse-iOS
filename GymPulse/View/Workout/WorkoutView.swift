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
            BackgroundImage()
            VStack {
                if viewModel.isTimerRunning {
                    HStack {
                        Text("Resting time: ")
                        Spacer()
                        Text("\(viewModel.formattedTime)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                }
                
                ForEach(workout.exercises) { exercise in
                    let isCurrentExercise = exercise.id == viewModel.currentExercise.id
                    
                    HStack {
                        if isCurrentExercise {
                            Text("Current Exercise: ")
                        }
                        Spacer()
                        Text(exercise.name)
                            .font(isCurrentExercise ? .title : .body)
                            .fontWeight(isCurrentExercise ? .bold : .regular)
                    }
                }
                
                HStack {
                    Text("Series: ")
                    Spacer()
                    Text("\(viewModel.currentSeries) / \(viewModel.currentExercise.seriesCount)")
                        .font(.title)
                }
                
                Spacer()
                
                Button {
                    if viewModel.isTimerRunning {
                        viewModel.nextSeries()
                        viewModel.stopTimer()
                    } else {
                        viewModel.startTimer()
                    }
                } label: {
                    Text(viewModel.isTimerRunning ? "Stop timer" : "Start rest")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle(workout.name)
        .onAppear {
            viewModel.setup(workout: workout, dismiss: dismiss, globalState: globalState)
        }
        .onReceive(viewModel.timer) { _ in
            // TODO: Refactor this condition
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
