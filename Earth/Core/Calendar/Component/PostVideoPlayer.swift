//
//  PostvideoPlayer.swift
//  Earth
//
//  Created by 이종선 on 6/5/24.
//

import SwiftUI
import AVKit

struct PostVideoPlayer: UIViewControllerRepresentable {
    
    var player: AVPlayer
    @Binding var isPlaying: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.videoGravity = .resizeAspectFill
        player.actionAtItemEnd = .none
        
        NotificationCenter.default.addObserver(
            context.coordinator,
            selector: #selector(context.coordinator.restartPlayback),
            name: AVPlayerItem.didPlayToEndTimeNotification,
            object: player.currentItem
        )
        
        return controller
        
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard let playerViewController = uiViewController as? AVPlayerViewController else { return }

        if isPlaying && playerViewController.player?.timeControlStatus != .playing {
            playerViewController.player?.play()
        } else if !isPlaying && playerViewController.player?.timeControlStatus == .playing {
            playerViewController.player?.pause()
        }
    }
    
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject{
        
        var parent: PostVideoPlayer
        
        init(parent: PostVideoPlayer){
            self.parent = parent
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        // 영상을 처음부터 재생
        @objc func restartPlayback(){
            parent.player.seek(to: .zero)
        }
        
    }
}
