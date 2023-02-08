//
//  StemSliderView.swift
//  STEMPLAYER
//
//  Created by Igor Łopatka on 22/12/2022.
//

import AVFoundation
import SwiftUI

struct CustomSliderView: View {
    
    var track: TrackModel
    
    // Credits: Kavsoft - https://www.youtube.com/watch?v=wdNu0ae5gBE
    
    @State var sliderProgress: CGFloat = 1
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    @State var sliderHeight: CGFloat = UIScreen.main.bounds.height / 3
    @State var lastDragValue: CGFloat = UIScreen.main.bounds.height / 3
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundColor(.gray)
            Rectangle()
                .foregroundColor(.accentColor)
                .frame(height: sliderHeight)
        }
        .frame(width: 20, height: maxHeight)
        .cornerRadius(12)
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged({ value in
                let translation = value.translation
                sliderHeight = -translation.height + lastDragValue
                sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                
                let progress = sliderHeight / maxHeight
                sliderProgress = progress <= 1.0 ? progress : 1
                track.player.volume = Float(sliderProgress)
            })
                .onEnded({ value in
                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                    lastDragValue = sliderHeight
                    
                    let progress = sliderHeight / maxHeight
                    sliderProgress = progress <= 1.0 ? progress : 1
                    track.player.volume = Float(sliderProgress)
                })
        )
    }
}

//    struct StemSliderView_Previews: PreviewProvider {
//        static var previews: some View {
//            CustomSliderView()
//    }
//}
