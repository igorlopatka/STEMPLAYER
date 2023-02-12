//
//  ContentView.swift
//  STEMPLAYER
//
//  Created by Igor Łopatka on 21/12/2022.
//

import AVFoundation
import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    
    @StateObject var stem = StemPlayerViewModel()
    
    @State private var isUploadingFiles = false
    @State private var filesLoaded = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.light
                    .ignoresSafeArea()
                VStack {
                    Image(colorScheme == . dark ? "logo_final_light" : "logo_final_dark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50)
                        .padding()
                    
                    Spacer()
                    
                    VStack {
                        if filesLoaded {
                            HStack {
                                ForEach(stem.tracks, id: \.id) { track in
                                    CustomSliderView(player: track.player)
                                        .foregroundColor(colorScheme == .dark ? .light : .dark)
                                }
                            }
                        } else {
                            Text("Upload tracks to start.")
                                .bold()
                        }
                    }
                    .frame(height: geo.size.height * 0.5)
                    Spacer()
                    HStack {
                        Button(action: {
                            stem.togglePlayStatus()
                        }) {
                            Image(systemName: stem.isPlaying ? "pause.fill" : "play.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(colorScheme == .dark ? .dark : .light)
                        }
                        .disabled(!filesLoaded)
                        .padding()
                        Button(action: {
                            stem.stopAllTracks()
                        }) {
                            Image(systemName: "stop.fill")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(colorScheme == .dark ? .dark : .light)
                            
                        }
                        .disabled(!filesLoaded)
                        .padding()
                    }
                    
                    Button {
                        isUploadingFiles = true
                    } label: {
                        Text("UPLOAD TRACKS")
                            .foregroundColor(.dark)
                            .shadow(radius: 2)
                        
                    }
                    .padding()
                }
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

