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
        ZStack(alignment: .leading) {
            Rectangle()
              .foregroundColor(.clear)
              .background(Color.customMediumBlue)
              .cornerRadius(10)
              .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
            
            HStack {
                ZStack(alignment: .center) {
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 50, height: 50)
                      .background(.red)
                      .cornerRadius(10)
                      .overlay(
                          RoundedRectangle(cornerRadius: 10)
                          .inset(by: 0.3)
                          .stroke(.black, lineWidth: 0.6)
                      )
                    Image(systemName: "dumbbell")
                        .font(.title3)
                }
                
                VStack(alignment: .leading) {
                    Text(workout.name)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                    
                    Text("\(workout.exercises.count) Exercises")
                        .font(.system(size: 14))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.title)
            }
            .padding(.horizontal)
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
