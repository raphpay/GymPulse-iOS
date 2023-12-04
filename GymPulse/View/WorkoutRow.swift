//
//  WorkoutRow.swift
//  GymPulse
//
//  Created by Raphaël Payet on 04/12/2023.
//

import SwiftUI

struct WorkoutRow: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
              .foregroundColor(.clear)
              .frame(width: 358, height: 90)
              .background(Color.customMediumBlue)
              .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        }
    }
}

#Preview {
    WorkoutRow()
}
