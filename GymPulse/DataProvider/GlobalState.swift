//
//  GlobalState.swift
//  GymPulse
//
//  Created by Raphaël Payet on 24/11/2023.
//

import Foundation

class GlobalState: ObservableObject {
    @Published var ringtone: Ringtone = .alert
}
