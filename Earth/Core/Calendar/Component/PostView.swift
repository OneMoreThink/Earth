//
//  PostView.swift
//  Earth
//
//  Created by 이종선 on 6/3/24.
//

import SwiftUI
import AVKit

struct PostView: View {
    
    @State var isPlaying: Bool = false
    @Environment(\.dismiss) var dismiss
    let post: Post
    @StateObject private var vm: VideoSeekBarViewModel
    @StateObject private var playerManager: AVPlayerManager
    
    init(post: Post) {
        self.post = post
        _vm = StateObject(wrappedValue: VideoSeekBarViewModel(player: post.player!))
        _playerManager = StateObject(wrappedValue: AVPlayerManager(player: post.player!))
    }
    
    
    var body: some View {
        
        ZStack{
            VStack{
                if let player = post.player {
                    PostVideoPlayer(playerManager: playerManager, isPlaying: $isPlaying)
                }
                
                
                VideoSeekBar(vm: vm, isPlaying: $isPlaying)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    HStack{
                        Image(systemName: "chevron.left")
                        Text("뒤로")
                    }
                    .foregroundStyle(.princeYellow)
                })
            }
        }
        .onAppear{
            isPlaying = true
            playerManager.play()
        }
        .onDisappear{
            isPlaying = false
            playerManager.pause()
        }
       
    }
}

