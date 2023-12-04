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
            ZStack {
                
                Image(Assets.appBackground)
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.6)
                
                VStack {
                    Image(Assets.logo)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 50)
                    Spacer()
                }
                
                if viewModel.filteredWorkouts.isEmpty {
                    emptyView
                } else {
                    workoutList
                }
            }
            .onAppear {
                viewModel.setup(authDataProvider, workouts: workouts)
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
                        Image(systemName: SFSymbols.profile.name)
                    }
                }
                
                if !workouts.isEmpty {
                    ToolbarItem {
                        Button {
                            viewModel.createWorkout(modelContext)
                        } label: {
                            Image(systemName: SFSymbols.plus.name)
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
        ScrollView {
            ForEach(viewModel.filteredWorkouts) { workout in
                NavigationLink {
                    WorkoutView(workout: workout)
                } label: {
                    WorkoutRow(workout: workout)
                }

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
