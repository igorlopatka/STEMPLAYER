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
    
    var body: some View {
        HStack{
            Button {
                isUploadingFiles = true
            } label: {
                Text("Upload")
            }
            
            VStack {
                Button(action: {
                    stem.playAllTracks()
                }) {
                    Image(systemName: "play.circle.fill").resizable().rotationEffect(Angle.degrees(90))
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                .padding()
                Button(action: {
                    stem.pauseAllTracks()
                }) {
                    Image(systemName: "pause.circle.fill").resizable().rotationEffect(Angle.degrees(90))
                        .frame(width: 50, height: 50)
                        .aspectRatio(contentMode: .fit)
                }
                .padding()
            }
            VStack {
                for track in stem.audioPlayers {
                    
                }
            }
        }
        .fileImporter(isPresented: $isUploadingFiles,
                      allowedContentTypes: [.audio],
                      allowsMultipleSelection: true) { result in
            if let urls = try? result.get() {
                for url in urls {
                    let url = url
                    stem.importedFiles.append(url)
                }
            }
        }
        .onChange(of: stem.importedFiles) { _ in
            stem.createTracks()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

