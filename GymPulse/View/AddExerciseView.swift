//
//  AddExerciseView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 24/11/2023.
//

import SwiftUI
import SwiftData

struct AddExerciseView: View {
    
    @Bindable var workout: Workout
    @Binding var showExerciseAlert: Bool
    @Binding var alertWidth: CGFloat
    @Binding var alertHeight: CGFloat
    @State private var selectedExerciseOption = ExerciseOption.classicSquat
    @State private var repsCount = 2
    @State private var seriesCount = 3
    @State private var weight = 50.0
    
    private let minimumWeight = 0.0
    private let maximumWeight = 200.0
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .onTapGesture {
                    hideAlert()
                }
            
            VStack {
                Text(workout.name)
                
                Picker("Please choose a color", selection: $selectedExerciseOption) {
                    ForEach(ExerciseOption.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                
                Stepper("Number of reps: \(repsCount)", value: $repsCount)
                Stepper("Number of series: \(seriesCount)", value: $seriesCount)
                
                HStack {
                    Button {
                        weight -= 0.5
                    } label: {
                        Image(systemName: "minus")
                    }
                    Slider(value: $weight, in: minimumWeight...maximumWeight,
                           step: 0.5) {
                        Text("Weight")
                    } minimumValueLabel: {
                        Text("\(Int(minimumWeight))")
                    } maximumValueLabel: {
                        Text("\(Int(maximumWeight))")
                    }
                    Button {
                        weight += 0.5
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("\(weight, specifier: "%.1f")")
                    Spacer()
                }
                
                Spacer()
                
                Button {
                    let exercise = Exercise(name: selectedExerciseOption.rawValue, seriesCount: seriesCount, repCount: repsCount, weight: weight)
                    workout.exercises.append(exercise)
                    hideAlert()
                } label: {
                    Text("Add Exercise")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .frame(width: alertWidth, height: alertHeight)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.white.opacity(0.9))
                    .frame(width: alertWidth, height: alertHeight)
            )
        }
        .ignoresSafeArea()
    }
    
    private func hideAlert() {
        withAnimation {
            showExerciseAlert = false
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Workout.self, configurations: config)
        let example = Workout(name: "Workout Example", breakDurationInS: 150)
        let exampleWidth = UIScreen.main.bounds.width - 32
        return AddExerciseView(workout: example,
                               showExerciseAlert: .constant(true),
                               alertWidth: .constant(exampleWidth),
                               alertHeight: .constant(350))
                                    .modelContainer(container)
    } catch {
        fatalError("Failed to create model container")
    }
}
