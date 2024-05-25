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
       reloadPosts()
    }
    
    
    private func setupPosts(){
        posts = postService.fetchAllPosts()
        if let firstPostId = posts.first?.id {
            currentPostID = firstPostId
            self.isPlaying = true
        }
    }
    
    private func reloadPosts(){
        DispatchQueue.global(qos: .userInteractive).async{ [weak self] in
            guard let self = self else {return}
            if let latestPost = self.postService.fetchLatestPost(){
                DispatchQueue.main.async {
                    self.posts.insert(latestPost, at: 0)
                    self.currentPostID = latestPost.id
                }
            }
        }
    }
    
    
    
    private func fetchSamplePosts(){
    
      posts = Post.mock
    }
    
}
