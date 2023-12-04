//
//  LogoImage.swift
//  GymPulse
//
//  Created by Raphaël Payet on 04/12/2023.
//

import SwiftUI

struct LogoImage: View {
    var body: some View {
        Image(Assets.logo)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 50)
    }
}

#Preview {
    LogoImage()
}
