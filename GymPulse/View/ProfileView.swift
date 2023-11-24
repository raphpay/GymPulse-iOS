//
//  ProfileView.swift
//  GymPulse
//
//  Created by Raphaël Payet on 23/11/2023.
//

import SwiftUI
import AVFoundation

struct ProfileView: View {
    
    @EnvironmentObject private var authDataProvider: AuthDataProvider
    @EnvironmentObject private var globalState: GlobalState
    @State private var audioPlayer: AVAudioPlayer?
    
    var body: some View {
        
        HStack {
            Text("Choose a ringtone:")
            Picker("Please choose a ringtone", selection: $globalState.ringtone) {
                ForEach(Ringtone.allCases, id: \.self) {
                    Text($0.fileName)
                }
            }
            Button {
                playRingtone()
            } label: {
                Image(systemName: "play.circle")
            }
        }
        
        

        
        Button {
            let result = AuthService.shared.signOut()
            switch result {
            case .success( _):
                authDataProvider.isLoggedIn = false
                authDataProvider.currentUser = nil
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        } label: {
            Text("Log out")
        }
    }
    
    func playRingtone() {
        guard let url = Bundle.main.url(forResource: globalState.ringtone.id, withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = audioPlayer else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ProfileView()
}
