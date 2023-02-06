//
//  ContentView.swift
//  STEMPLAYER
//
//  Created by Igor Łopatka on 21/12/2022.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    
    @StateObject var stem = StemPlayerViewModel()
    @State private var isUploadingFiles = false
    @State private var filesLoaded = false
    
    var body: some View {
        HStack{
            Button {
                isUploadingFiles = true
            } label: {
                Text("Upload")
            }
            
            VStack {
                Button(action: {
                    stem.togglePlayStatus()
                }) {
                    Image(systemName: stem.isPlaying ? "pause.fill" : "play.fill")
                        .resizable()
                        .rotationEffect(Angle.degrees(90))
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                .disabled(!filesLoaded)
                .padding()
                Button(action: {
                    stem.stopAllTracks()
                }) {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .rotationEffect(Angle.degrees(90))
                        .frame(width: 45, height: 45)
                        .aspectRatio(contentMode: .fit)
                }
                .disabled(!filesLoaded)
                .padding()
            }
    
            if filesLoaded {
                VStack {
                    ForEach(stem.tracks) { track in
                        StemSliderView(track: track)
                    }
                }
            } else {
                Text("Upload tracks to start.")
                    .bold()
            }
        }
        .fileImporter(isPresented: $isUploadingFiles,
                      allowedContentTypes: [.audio],
                      allowsMultipleSelection: true) { result in
            stem.importFiles(result: result)
        }
        .onChange(of: stem.importedFiles) { _ in
            stem.createTracks()
            if stem.importedFiles.isEmpty == false {
                filesLoaded = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

