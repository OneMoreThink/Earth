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
    
    init(post: Post) {
        self.post = post
    }
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            ZStack{
                VStack(spacing: 0){
                    if let player = post.player {
                        SeekVideoPlayer(size: size, player: player, isPlaying: $isPlaying)
                            .ignoresSafeArea(.all)
                    } else {
                        if #available(iOS 17.0, *) {
                            ContentUnavailableView("기록을 찾지 못했어요", systemImage: "star.slash")
                        } else {
                            UnavailableView()
                        }
                    }
                }
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
            if let player = post.player {
                player.play()
                isPlaying = true
            }
        }
        .onDisappear{
            if let player = post.player{
                player.pause()
                isPlaying = false
            }
        }
        
    }
    
    @ViewBuilder
    private func UnavailableView() -> some View {
        VStack(spacing: 12){
            Image(systemName: "star.slash")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("기록을 찾지 못했어요")
                .fontWeight(.bold)
        }
    }
}

