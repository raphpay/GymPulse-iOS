//
//  WorkoutView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI
import SwiftData

struct WorkoutView: View {
    
    @Bindable var workout: Workout
    
    var body: some View {
        VStack {
            Text(workout.name)
            Text("\(workout.breakDurationInS)")
            ForEach(workout.exercises) { exercise in
                Text(exercise.name)
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        let example = Workout(name: "Workout Example", breakDurationInS: 150)
        return WorkoutView(workout: example)
                                    .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
