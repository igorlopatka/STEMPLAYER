//
//  StemViewModel.swift
//  STEMPLAYER
//
//  Created by Igor Łopatka on 21/12/2022.
//

import AVFoundation
import SwiftUI

@MainActor class StemPlayerViewModel: ObservableObject {
    
    @Published private(set) var importedFiles: [URL] = []
    @Published private(set) var tracks: [TrackModel] = []
    @Published private(set) var isPlaying = false
    
    func importFiles(result: Result<[URL], Error>) {
        resetImportedFiles()
        
        if let urls = try? result.get() {
            for url in urls {
                let url = url
                url.startAccessingSecurityScopedResource()
                importedFiles.append(url)
            }
        }
    }
    
    func togglePlayStatus() {
        isPlaying ? pauseAllTracks() : playAllTracks()
    }
    
    func playAllTracks() {
        tracks.forEach { $0.player.play() }
        isPlaying = true
    }
    
    func pauseAllTracks() {
        tracks.forEach { $0.player.pause() }
        isPlaying = false
    }
    
    func stopAllTracks() {
        tracks.forEach {
            $0.player.stop()
            $0.player.currentTime = 0.0
        }
        isPlaying = false
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
    
    func resetImportedFiles() {
        importedFiles = []
    }
}
