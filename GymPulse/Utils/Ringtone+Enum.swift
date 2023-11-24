//
//  SystemSound.swift
//  GymPulse
//
//  Created by Raphaël Payet on 24/11/2023.
//

import Foundation

enum Ringtone: String, CaseIterable, Identifiable {
    
    case alert, happy, retro, simple
    
    var id: String {
        self.rawValue
    }
    
    var fileName: String {
        self.rawValue.capitalized
    }
}

typealias SystemSoundID = UInt32
