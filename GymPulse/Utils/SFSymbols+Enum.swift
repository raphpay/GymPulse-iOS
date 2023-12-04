//
//  SFSymbols+Enum.swift
//  GymPulse
//
//  Created by Raphaël Payet on 04/12/2023.
//

import Foundation

enum SFSymbols: String {
    case profile = "person.fill"
    case plus = "plus"
    case minus = "minus"
    case play = "play.circle"
    case pause = "pause.circle"
    case delete = "trash"
    case forward = "chevron.right"
    
    var name: String {
        self.rawValue
    }
}
