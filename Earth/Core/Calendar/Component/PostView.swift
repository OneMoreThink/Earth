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
    
    let postService = PostService.shared
    @State private var isAlertPresented = false
    
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
            .alert(isPresented: $isAlertPresented){
                Alert(title: Text("삭제 확인"), message: Text("이 순간을 떠나보낼까요?"), primaryButton: .destructive(Text("삭제"), action: {
                    postService.deletePost(post: post)
                    dismiss()
                }), secondaryButton: .cancel(Text("취소")))
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
            
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isAlertPresented.toggle()
                }, label: {
                    Image(systemName: "star.slash")
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

