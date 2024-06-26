//
//  PostvideoPlayer.swift
//  Earth
//
//  Created by 이종선 on 6/5/24.
//

import SwiftUI
import AVKit

struct PostVideoPlayer: UIViewControllerRepresentable {
    
    @ObservedObject var playerManager: AVPlayerManager
    @Binding var isPlaying: Bool
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = playerManager.player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        playerManager.player?.actionAtItemEnd = .none
        
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(context.coordinator.restartPlayback),
            name: .AVPlayerItemDidPlayToEndTime,
            object: playerManager.player?.currentItem
        )
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if isPlaying {
            playerManager.play()
        } else {
            playerManager.pause()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        
        var parent: PostVideoPlayer
        
        init(parent: PostVideoPlayer){
            self.parent = parent
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        @objc func restartPlayback(){
            parent.playerManager.reset()
            parent.playerManager.play()
        }
    }
}
