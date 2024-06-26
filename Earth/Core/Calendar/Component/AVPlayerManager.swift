//
//  AVPlayerManager.swift
//  Earth
//
//  Created by 이종선 on 6/18/24.
//

import SwiftUI
import AVKit

class AVPlayerManager: ObservableObject {
    @Published var player: AVPlayer?
    
    init(player: AVPlayer?) {
        self.player = player
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func reset() {
        player?.seek(to: .zero)
        player?.pause()
    }
}
