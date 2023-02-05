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
    @Published var tracks: [TrackModel] = []
    
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
        tracks.forEach { $0.player.play() }
    }
    
    func pauseAllTracks() {
        tracks.forEach { $0.player.pause() }
    }
    
    func createTracks() {
        clearTracks()
        for file in importedFiles {
            do {
                let player = try AVAudioPlayer(contentsOf: file)
                let track = TrackModel(fileName: file.lastPathComponent, player: player, url: file)
                tracks.append(track)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func clearTracks() {
        tracks = []
    }
}
