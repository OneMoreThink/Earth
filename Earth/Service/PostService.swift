//
//  PostService.swift
//  Earth
//
//  Created by 이종선 on 4/14/24.
//

import Foundation

class PostService {
    
    static let shared = PostService()
    private init(){}
    
    private let fileManager = MediaFileManager.shared
    private let coreManager = CoreDataManager.shared
    
    func fetchAllPosts() -> [Post]{
        return coreManager.fetchAllPosts()
    }
    
    func createNewPost(from srcURL: URL, to destFileName: String){
        
        if let videoUrl = fileManager.moveFile(from: srcURL, to: destFileName){
            coreManager.createPost(videoUrl: videoUrl)
        }
    }
    
    func deletePost(post: Post){
        
        if let videoUrl =  coreManager.deletePost(id: post.id){
            fileManager.deleteFile(fileName: videoUrl)
        }
    }
    
}
