//
//  PostView.swift
//  Earth
//
//  Created by 이종선 on 6/3/24.
//

import SwiftUI

struct PostView: View {
    
    @State var isPlaying: Bool = false
    @Environment(\.dismiss) var dismiss
    let post: Post
    var body: some View {
        
        ZStack{
            if let player = post.player {
                PostVideoPlayer(player: player, isPlaying: $isPlaying)
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
        }
       
    }
}

