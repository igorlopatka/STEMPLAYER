//
//  StemSliderView.swift
//  STEMPLAYER
//
//  Created by Igor Łopatka on 22/12/2022.
//

import AVFoundation
import SwiftUI

struct StemSliderView: View {
    
    var player: AVPlayer
    
    var body: some View {
        Slider(value: Binding(get: {
            player.volume
        }, set: { (newVal) in
            player.volume = newVal
        }))
    }
}

//struct StemSliderView_Previews: PreviewProvider {
//    static var previews: some View {
//        StemSliderView()
//    }
//}
