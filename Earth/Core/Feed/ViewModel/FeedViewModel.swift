//
//  FeedViewModel.swift
//  Earth
//
//  Created by 이종선 on 4/9/24.
//

import Foundation
import AVKit
import CoreData

class FeedViewModel: ObservableObject {
    
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
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(willReceiveDataSaveNotification(_:)), name: .willSaveContext, object: nil)
        setupPosts()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didSaveContext, object: nil)
        NotificationCenter.default.removeObserver(self, name: .willSaveContext, object: nil)
    }
    
    @objc private func willReceiveDataSaveNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo else {
            print("No userInfo found in notification")
            return
        }
        
        var postsToDelete = [String]()
        
        if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>, !deletes.isEmpty {
            for delete in deletes {
                if let postEntity = delete as? PostEntity {
                    let postId = postEntity.id
                    print("Will delete post with ID: \(postId)")
                    postsToDelete.append(postId)
                }
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            for postId in postsToDelete {
                print("Attempting to remove post with ID: \(postId)")
                if let index = self.posts.firstIndex(where: { $0.id == postId }) {
                    self.posts.remove(at: index)
                    print("Post removed from posts array at index: \(index)")
                    
                    // currentPostID를 업데이트
                    if index > 0 {
                        self.currentPostID = self.posts[index - 1].id
                    } else if !self.posts.isEmpty {
                        self.currentPostID = self.posts.first!.id
                    } else {
                        self.currentPostID = ""
                    }
                    print("Updated currentPostID: \(self.currentPostID)")
                } else {
                    print("Post not found in posts array with ID: \(postId)")
                }
            }
        }
    }
    
    @objc private func didReceiveDataSaveNotification(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo else { return }
        
        if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>, !inserts.isEmpty {
            reloadPosts()
        }

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
                    // feedView의 새로운 동영상의 업데이트가 완료되었을 때 RecordingView를 내리기 위한 알람
                    NotificationCenter.default.post(name: .didReloadPosts, object: nil)
                }
            }
        }
    }
    
    
    private func fetchSamplePosts(){
    
      posts = Post.mock
    }
    
}
