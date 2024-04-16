//
//  FeedViewModel.swift
//  Earth
//
//  Created by 이종선 on 4/9/24.
//

import Foundation
import AVKit

class FeedViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    @Published var isPlaying: Bool = false
    @Published var currentPostID: String = ""  // 현재 재생 상태를 관리
    let postService = PostService.shared
    
    init(){
        NotificationCenter
            .default
            .addObserver(self, 
                         selector: #selector(didReceiveDataSaveNotification(_:)), 
                         name: .didSaveContext, object: nil)
        setupPosts()
    }
    
    @objc private func didReceiveDataSaveNotification(_ notification: Notification) {
        setupPosts()
        if let newPostId = posts.first?.id{
            currentPostID = newPostId
        }
    }
    
    
    private func setupPosts(){
       posts = postService.fetchAllPosts()
    }
    
    
    private func fetchSamplePosts(){
    
      posts = Post.mock
    }
    
}
