//
//  FeedCell.swift
//  Earth
//
//  Created by 이종선 on 4/9/24.
//

import SwiftUI
import AVKit

struct FeedCell: View {
    
    var post: Post
    @Binding var currentPost: String
    @Binding var isPlaying: Bool
    
    var body: some View {
        
        ZStack{
            
            if let player = post.player{
                CustomVideoPlayer(player: player, isPlaying: $isPlaying)
                GeometryReader{ proxy -> Color in
                    let minY = proxy.frame(in: .global).minY
                    let size = proxy.size
                    DispatchQueue.main.async {
                        if isPlaying && -minY < (size.height / 2) && minY < (size.height / 2) && (currentPost == post.id){
                            player.play()
                        }
                        else {
                            player.pause()
                        }
                    }
                    return Color.clear
                }
            }
        }
    }
}

