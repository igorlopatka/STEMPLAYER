//
//  Track.swift
//  STEMPLAYER
//
//  Created by Igor Łopatka on 22/12/2022.
//

import AVFoundation
import Foundation

struct TrackModel: Identifiable {
    
    let id = UUID()
    let player: AVAudioPlayer
    let url: URL
    
}
