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
    @StateObject private var viewModel = AddExerciseViewModel()
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .onTapGesture {
                    hideAlert()
                }
            
            VStack {
                Text(workout.name)
                
                Picker("Please choose a color", selection: $viewModel.selectedExerciseOption) {
                    ForEach(ExerciseOption.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                
                Stepper("Number of reps: \(viewModel.repsCount)", value: $viewModel.repsCount)
                Stepper("Number of series: \(viewModel.seriesCount)", value: $viewModel.seriesCount)
                
                HStack {
                    Button {
                        viewModel.weight -= 0.5
                    } label: {
                        Image(systemName: "minus")
                    }
                    Slider(value: $viewModel.weight, in: viewModel.minimumWeight...viewModel.maximumWeight,
                           step: 0.5) {
                        Text("Weight")
                    } minimumValueLabel: {
                        Text("\(Int(viewModel.minimumWeight))")
                    } maximumValueLabel: {
                        Text("\(Int(viewModel.maximumWeight))")
                    }
                    Button {
                        viewModel.weight += 0.5
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                HStack(alignment: .center) {
                    Spacer()
                    Text("\(viewModel.weight, specifier: "%.1f")")
                    Spacer()
                }
                
                Spacer()
                
                Button {
                    viewModel.saveWorkout(workout: workout)
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
            self.showExerciseAlert = false
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
