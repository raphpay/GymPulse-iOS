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
                
                BackgroundImage()
                
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
                            .modifier(ToolbarModifier())
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    LogoImage()
                }
                
                if !workouts.isEmpty {
                    ToolbarItem {
                        Button {
                            viewModel.createWorkout(modelContext)
                        } label: {
                            Image(systemName: SFSymbols.plus.name)
                                .modifier(ToolbarModifier())
                        }
                    }
                }
            }
        }
    }
    
    var emptyView: some View {
        ContentUnavailableView(label: {
            Label("No Workouts", systemImage: SFSymbols.dumbbell.name)
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

struct ToolbarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(4)
            .background(
                Circle()
                    .foregroundColor(.customLightBlue)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            )
    }
}


#Preview {
    MainView()
}
