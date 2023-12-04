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
    
    var ownerID: String?
    
    func setup(_ authDataProvider: AuthDataProvider, workouts: [Workout]) {
        self.ownerID = authDataProvider.currentUser?.uid
        guard let ownerID = self.ownerID else { return }
        filteredWorkouts = workouts.filter({ $0.ownerID == ownerID })
    }
    
    func createWorkout(_ modelContext: ModelContext) {
        guard let ownerID = self.ownerID else { return }
        let workout = Workout(ownerID: ownerID, name: "Workout \(Int.random(in: 1...100))", breakDurationInS: 150)
        modelContext.insert(workout)
        path.append(workout)
    }
    
    func clearWorkouts(_ modelContext: ModelContext) {
        guard let ownerID = self.ownerID else { return }
        do {
            try modelContext.delete(model: Workout.self, where: #Predicate { workout in
                workout.ownerID == ownerID
            })
            withAnimation { self.filteredWorkouts = [] }
        } catch let error {
            print(error)
        }
    }
}
