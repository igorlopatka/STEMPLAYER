//
//  StemViewModel.swift
//  STEMPLAYER
//
//  Created by Igor Łopatka on 21/12/2022.
//

import AVFoundation
import SwiftUI

@MainActor class StemPlayerViewModel: ObservableObject {
    
    @Published var importedFiles: [URL] = []
    @Published var audioPlayers: [AVAudioPlayer] = []
    
    func importFiles(results: [Result<URL, Error>]) {
        for result in results {
            switch result {
            case .success(let url):
                importedFiles.append(url)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func playAllTracks() {
        audioPlayers.forEach { $0.play() }
    }
    
    func pauseAllTracks() {
        audioPlayers.forEach { $0.pause() }
    }
    
    
    func createTracks() {
        for file in importedFiles {
            do {
                let player = try AVAudioPlayer(contentsOf: file)
                audioPlayers.append(player)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
