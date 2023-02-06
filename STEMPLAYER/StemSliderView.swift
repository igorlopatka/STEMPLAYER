//
//  StemSliderView.swift
//  STEMPLAYER
//
//  Created by Igor Łopatka on 22/12/2022.
//

import AVFoundation
import SwiftUI

struct StemSliderView: View {
    
    var track: TrackModel
    
    var body: some View {
        Text(track.fileName)
        Slider(value: Binding(get: {
            track.player.volume
        }, set: { (newVal) in
            track.player.volume = newVal
        }))
    }
}
