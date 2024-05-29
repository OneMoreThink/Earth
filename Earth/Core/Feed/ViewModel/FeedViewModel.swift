//
//  FeedViewModel.swift
//  Earth
//
//  Created by 이종선 on 4/9/24.
//

import Foundation
import AVKit

class FeedViewModel: ObservableObject {
    
    @Published var selectedTab: String = "person.crop.rectangle.stack"
    @Published var previousTab: String = "person.crop.rectangle.stack"
    @Published var posts: [Post] = []
    @Published var isPlaying: Bool = false
    @Published var currentPostID: String = ""
    @Published var isLoading: Bool = true
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
        
        DispatchQueue.global(qos: .userInteractive).async{ [weak self] in
            guard let self = self else {return}
            let fetchedPosts = self.postService.fetchAllPosts()
            DispatchQueue.main.async {
                self.posts = fetchedPosts
                self.isLoading = false
                if let firstPostId = fetchedPosts.first?.id{
                    self.currentPostID = firstPostId
                }
            }
            
        }
    }
    
    private func reloadPosts(){
        DispatchQueue.global(qos: .userInteractive).async{ [weak self] in
            guard let self = self else {return}
            if let latestPost = self.postService.fetchLatestPost(){
                DispatchQueue.main.async {
                    self.posts.insert(latestPost, at: 0)
                    self.currentPostID = latestPost.id
                    NotificationCenter.default.post(name: .didReloadPosts, object: nil)
                    if self.previousTab == "person.crop.rectangle.stack"{
                        self.isPlaying = true
                    }
                }
            }
        }
    }
    
    
    
    private func fetchSamplePosts(){
    
      posts = Post.mock
    }
    
}
