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
    @StateObject private var viewModel = MainViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
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
            .navigationDestination(isPresented: $viewModel.showProfileView) {
                ProfileView()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        viewModel.showProfileView = true
                    } label: {
                        Image(systemName: "person.fill")
                    }
                }
                
                if !workouts.isEmpty {
                    ToolbarItem {
                        Button {
                            viewModel.createWorkout(modelContext)
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
                viewModel.createWorkout(modelContext)
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
                viewModel.clearWorkouts(modelContext)
            } label: {
                Text("Clear")
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    MainView()
}
