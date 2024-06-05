//
//  VideoSeekBar.swift
//  Earth
//
//  Created by 이종선 on 6/3/24.
//

import SwiftUI
import AVKit

class VideoSeekBarViewModel: ObservableObject {
    @Published var currentTime: Double = 0.0
    @Published var duration: Double = 0.0
    var timeObserverToken: Any?
    let player: AVPlayer
    
    init(player: AVPlayer){
        self.player = player
        addTimeObserver(player: player)
    }
    
    deinit {
        if let token = timeObserverToken {
            player.removeTimeObserver(token)
        }
    }
    
    func addTimeObserver(player: AVPlayer){
        let interval = CMTime(seconds: 1, preferredTimescale: 600)
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.currentTime = time.seconds
            if let duration = player.currentItem?.duration.seconds, duration.isFinite {
                self.duration = duration
            }
        }
    }
}

struct VideoSeekBar: View {
    
    @State private var currentTime: Double = 0.0
    @State private var duration: Double = 0.0
    let player: AVPlayer
    @Binding var isPlaying: Bool
    private var timeObserverToken: Any?
    
    
    var body: some View {
        
        
        VStack{
            HStack{
                Text("")
                Spacer()
                Text("")
            }
            .padding(.horizontal)
            
            
        }
        
    }
    
}

