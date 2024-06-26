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
    
    @ObservedObject var vm: VideoSeekBarViewModel
    @Binding var isPlaying: Bool
    
    var body: some View {
        
        
        VStack{
            HStack{
                Text(formatTime(seconds: vm.currentTime))
                Spacer()
                Text(formatTime(seconds: vm.duration))
            }
            
            Slider(value: $vm.currentTime, in: 0...vm.duration, onEditingChanged: sliderEditingChanged )
        }
        .padding(.horizontal)
        
    }
    
    private func sliderEditingChanged(editingStarted: Bool){
        if editingStarted {
            vm.player.pause()
        } else {
            let newTime = CMTime(seconds: vm.currentTime, preferredTimescale: 600)
            vm.player.seek(to: newTime) { _ in
                if isPlaying {
                    vm.player.play()
                }
            }
        }
    }
    
    private func formatTime(seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
