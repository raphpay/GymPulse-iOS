//
//  MainView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject private var authDataProvider: AuthDataProvider
    @Query var workouts: [Workout]
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if workouts.isEmpty {
                    emptyView
                } else {
                    workoutList
                }
            }
            .navigationDestination(for: Workout.self) { _ in
                EmptyView()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        // TODO: Go to profile view
                    } label: {
                        Image(systemName: "person.fill")
                    }
                }
                
                if !workouts.isEmpty {
                    ToolbarItem {
                        Button {
                            createWorkout()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
        }
    }
    
    var emptyView: some View {
        ContentUnavailableView(label: {
            Label("No Workouts", systemImage: "dumbbell")
        }, description: {
            Text("Start creating a workout to use the app")
        }, actions: {
            Button {
                createWorkout()
            } label: {
                Text("Create")
            }
            .buttonStyle(.bordered)
        })
    }
    
    var workoutList: some View {
        VStack {
            ForEach(workouts) { workout in
                Text(workout.name)
            }
            
            Button {
                clearWorkouts()
            } label: {
                Text("Clear")
            }
            .buttonStyle(.bordered)
        }
    }
    
    func createWorkout() {
        let workout = Workout(name: "Workout \(Int.random(in: 1...100))", breakDurationInS: 150)
        modelContext.insert(workout)
        path.append(workout)
    }
    
    func clearWorkouts() {
        do {
            try modelContext.delete(model: Workout.self)
        } catch let error {
            print(error)
        }
    }
}

#Preview {
    MainView()
}
