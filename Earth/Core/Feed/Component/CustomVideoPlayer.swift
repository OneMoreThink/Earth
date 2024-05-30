//
//  CustomVideoPlayer.swift
//  Earth
//
//  Created by 이종선 on 4/9/24.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
    
    var player: AVPlayer
    @Binding var isPlaying: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = AVPlayerViewController()
        controller.player = player // 재생할 파일 player에 넣어주기
        controller.showsPlaybackControls = false // 재생 컨트롤러 숨기기
        controller.videoGravity = .resizeAspectFill // video가 player view 경계를 종횡비를 유지하며 모두 채움
        
        player.actionAtItemEnd = .none // video가 끝났을 때의 동작을 직접 제어하기 위해 .none 설정
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
    
    // Coordinator는 CustomVideoPlayer와 함께 동작을 제어하는 보조 객체
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    class Coordinator: NSObject {
        
        var parent: CustomVideoPlayer
        
        init(parent: CustomVideoPlayer){
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

