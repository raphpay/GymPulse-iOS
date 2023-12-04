//
//  WorkoutRow.swift
//  GymPulse
//
//  Created by Raphaël Payet on 04/12/2023.
//

import SwiftUI
import SwiftData

struct WorkoutRow: View {
    @Bindable var workout: Workout
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.customMediumBlue)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 0.6)
                        .frame(width: 50, height: 50)
                    
                    Image(systemName: SFSymbols.dumbbell.name)
                        .font(.title3)
                }
                
                VStack(alignment: .leading) {
                    Text(workout.name)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    
                    Text("\(workout.exercises.count) exercises")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                }
                
                Spacer()
                
                Image(systemName: SFSymbols.forward.name)
                    .font(.title2)
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 90)
        .tint(.black)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        let example = Workout(ownerID: "TestID", name: "Workout Example", breakDurationInS: 150)
        return WorkoutRow(workout: example)
                                    .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
