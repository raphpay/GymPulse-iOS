//
//  MainViewModel.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI
import SwiftData
import FirebaseAuth

class MainViewModel: ObservableObject {
    @Published var path = NavigationPath()
    @Published var showProfileView = false
    @Published var filteredWorkouts = [Workout]()
    
    func filterWorkouts(workouts: [Workout], currentUser: User?) {
        guard let ownerID = currentUser?.uid else { return }
        filteredWorkouts = workouts.filter({ $0.ownerID == ownerID })
    }
    
    func createWorkout(_ modelContext: ModelContext, currentUser: User?) {
        guard let ownerID = currentUser?.uid else { return }
        let workout = Workout(ownerID: ownerID, name: "Workout \(Int.random(in: 1...100))", breakDurationInS: 150)
        modelContext.insert(workout)
        path.append(workout)
    }
    
    func clearWorkouts(_ modelContext: ModelContext, currentUser: User?) {
        guard let ownerID = currentUser?.uid else { return }
        do {
            try modelContext.delete(model: Workout.self, where: #Predicate { workout in
                workout.ownerID == ownerID
            })
        } catch let error {
            print(error)
        }
    }
}
