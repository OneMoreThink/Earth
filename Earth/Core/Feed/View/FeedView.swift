//
//  FeedView.swift
//  Earth
//
//  Created by 이종선 on 4/9/24.
//

import SwiftUI
import AVKit

struct FeedView: View {
    
    @ObservedObject var vm: FeedViewModel
    
    var body: some View {
        
        // TabView(sliding)을 뒤집어서 사용
        GeometryReader{ proxy in
            
            let size = proxy.size
            
            TabView(selection: $vm.currentPostID){
                
                ForEach(vm.posts){ post in
                    FeedCell(post: post, currentPost: $vm.currentPostID, isPlaying: $vm.isPlaying)
                        .frame(width: size.width)
                        .rotationEffect(.init(degrees: -90))
                        .ignoresSafeArea(.all)
                        .tag(post.id)
                    
                    
                }
            }
            .rotationEffect(.init(degrees: 90))
            .frame(width: size.height)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: size.width)
            .ignoresSafeArea(.all)
            
        }
        .onAppear{
            vm.isPlaying = true
        }

        .onDisappear{
            vm.isPlaying = false 
        }
    
}
    
    
}

#Preview {
    FeedView(vm: FeedViewModel())
}
