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
}
