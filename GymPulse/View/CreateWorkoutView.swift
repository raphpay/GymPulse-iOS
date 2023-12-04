//
//  CreateWorkoutView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI
import SwiftData

struct CreateWorkoutView: View {
    
    @Bindable var workout: Workout
    @StateObject private var viewModel = CreateWorkoutViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Workout Name", text: $workout.name)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    Text("Break duration:")
                    Picker("Minutes", selection: $viewModel.minutes) {
                        ForEach(0..<11) { minute in
                            Text("\(minute)min")
                        }
                    }
                    .onChange(of: viewModel.minutes) { _, _ in
                        viewModel.updateWorkoutDuration(workout: workout)
                    }
                    
                    Picker("Seconds", selection: $viewModel.seconds) {
                        ForEach(0..<60) { second in
                            Text("\(second)sec")
                        }
                    }
                    .onChange(of: viewModel.seconds) { _, _ in
                        viewModel.updateWorkoutDuration(workout: workout)
                    }
                }
                
                ForEach(0..<workout.exercises.count, id: \.self) { index in
                    let exercise = workout.exercises[index]
                    
                    HStack {
                        Spacer()
                        Text(exercise.name)
                        Spacer()
                        Button {
                            workout.exercises.remove(at: index)
                        } label: {
                            Image(systemName: SFSymbols.delete.name)
                                .tint(.red)
                        }
                    }
                }
                
                Button {
                    withAnimation {
                        viewModel.showExerciseAlert = true
                        viewModel.alertWidth = UIScreen.main.bounds.width - 36
                        viewModel.alertHeight = 350
                    }
                } label: {
                    Text("Add exercise")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .onAppear {
                viewModel.updatePickersFromWorkoutDuration(workout: workout)
            }
            
            if viewModel.showExerciseAlert {
                AddExerciseView(workout: workout,
                                showExerciseAlert: $viewModel.showExerciseAlert,
                                alertWidth: $viewModel.alertWidth,
                                alertHeight: $viewModel.alertHeight)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        let exampleExercise = Exercise(name: ExerciseOption.classicSquat.rawValue,
                                       seriesCount: 3, repCount: 3, weight: 50)
        let example = Workout(ownerID: "TestOwner",
                              name: "Workout Example",
                              breakDurationInS: 150,
                              exercises: [exampleExercise])
        
        return CreateWorkoutView(workout: example)
                                    .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
