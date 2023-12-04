//
//  BackgroundView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 04/12/2023.
//

import SwiftUI

struct BackgroundImage: View {
    var body: some View {
        Image(Assets.appBackground)
            .resizable()
            .ignoresSafeArea()
            .opacity(0.6)
    }
}

#Preview {
    BackgroundImage()
}
