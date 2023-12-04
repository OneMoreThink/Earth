//
//  VideoPlayer.swift
//  Earth
//
//  Created by 이종선 on 12/4/23.
//

import SwiftUI
import AVKit

// Custom Video Player from UIKit


struct CustomVideoPlayer: UIViewControllerRepresentable {
    
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> some AVPlayerViewController {
        
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        
        controller.videoGravity = .resizeAspectFill
        
        // repeating playback
        player.actionAtItemEnd = .none
        
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayback), name: AVPlayerItem.didPlayToEndTimeNotification, object: player.currentItem)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        
        var parent: CustomVideoPlayer
        
        init(parent: CustomVideoPlayer){
            self.parent = parent
        }
        
        @objc func restartPlayback(){
            parent.player.seek(to: .zero)
        }
    }
}

