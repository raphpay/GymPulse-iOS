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
                if viewModel.filteredWorkouts.isEmpty {
                    emptyView
                } else {
                    workoutList
                }
            }
            .onAppear {
                // TODO: Find a way to pass authdataprovider to the viewmodel
                viewModel.filterWorkouts(workouts: workouts, currentUser: authDataProvider.currentUser)
            }
            .navigationDestination(for: Workout.self) { workout in
                CreateWorkoutView(workout: workout)
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
                            viewModel.createWorkout(modelContext, currentUser: authDataProvider.currentUser)
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
                viewModel.createWorkout(modelContext, currentUser: authDataProvider.currentUser)
            } label: {
                Text("Create")
            }
            .buttonStyle(.bordered)
        })
    }
    
    var workoutList: some View {
        VStack {
            ForEach(viewModel.filteredWorkouts) { workout in
                NavigationLink {
                    WorkoutView(workout: workout)
                } label: {
                    Text(workout.name)
                }

            }
            
            Button {
                viewModel.clearWorkouts(modelContext, currentUser: authDataProvider.currentUser)
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
