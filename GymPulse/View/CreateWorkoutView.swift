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
    @State private var minutes = 0
    @State private var seconds = 0
    @State private var showExerciseAlert = false
    @State private var alertWidth: CGFloat = 0.0
    @State private var alertHeight: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Workout Name", text: $workout.name)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    Text("Break duration:")
                    Picker("Minutes", selection: $minutes) {
                        ForEach(0..<11) { minute in
                            Text("\(minute)min")
                        }
                    }
                    .onChange(of: minutes) { _, _ in
                        updateWorkoutDuration()
                    }
                    
                    Picker("Seconds", selection: $seconds) {
                        ForEach(0..<60) { second in
                            Text("\(second)sec")
                        }
                    }
                    .onChange(of: seconds) { _, _ in
                        updateWorkoutDuration()
                    }
                }
                
                ForEach(workout.exercises) { exercise in
                    Text(exercise.name)
                }
                
                Button {
                    withAnimation {
                        showExerciseAlert = true
                        alertWidth = UIScreen.main.bounds.width - 36
                        alertHeight = 350
                    }
                } label: {
                    Text("Add exercise")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .onAppear {
                updatePickersFromWorkoutDuration()
            }
            
            if showExerciseAlert {
                AddExerciseView(workout: workout, showExerciseAlert: $showExerciseAlert,
                                alertWidth: $alertWidth, alertHeight: $alertHeight)
            }
        }
    }
    
    func updatePickersFromWorkoutDuration() {
        let totalSeconds = Int(workout.breakDurationInS)
        minutes = totalSeconds / 60
        seconds = totalSeconds % 60
    }
    
    func updateWorkoutDuration() {
        let totalSeconds = minutes * 60 + seconds
        workout.breakDurationInS = Double(totalSeconds)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        let example = Workout(name: "Workout Example", breakDurationInS: 150)
        return CreateWorkoutView(workout: example)
                                    .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
