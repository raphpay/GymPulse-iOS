//
//  MainViewModel.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI
import SwiftData

class MainViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var showProfileView = false
    
    func createWorkout(_ modelContext: ModelContext) {
        let workout = Workout(name: "Workout \(Int.random(in: 1...100))", breakDurationInS: 150)
        modelContext.insert(workout)
        path.append(workout)
    }
    
    func clearWorkouts(_ modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Workout.self)
        } catch let error {
            print(error)
        }
    }
}
