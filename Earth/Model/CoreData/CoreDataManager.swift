//
//  CoreDataManager.swift
//  Earth
//
//  Created by 이종선 on 4/14/24.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private let mainContext : NSManagedObjectContext
    
    private init(){
        mainContext = PersistenceController.shared.container.viewContext
    }
    
    // Create Post
    func createPost(videoUrl: String){
        
        let postEntity = PostEntity(context: mainContext)
        postEntity.id = UUID().uuidString
        postEntity.videoUrl = videoUrl
        postEntity.createdAt = Date()
        
        do{
            try mainContext.save()
            
        } catch {
            print("Failed to save post: \(error)")
        }
        
    }
    
    // Fetch Posts
    func fetchAllPosts() -> [Post]{
        
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false) // 최신 날짜가 먼저 오도록 정렬
        request.sortDescriptors = [sortDescriptor]
        
        do {
            let result = try mainContext.fetch(request)
            return result.map{Post.from(entity: $0)}
        } catch {
        
            print("Failed to fetch posts: \(error)")
                   return []
            
        }
    }
    
    // Fetch Latest Post
    func fetchLatestPost() -> Post?{
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "createdAt", ascending: false)
        request.fetchLimit = 1
        request.sortDescriptors = [sortDescriptors]
        
        do{
            let result = try mainContext.fetch(request)
            return result.first.map{Post.from(entity: $0)}
        } catch {
            print("Failed to fetch latest post: \(error)")
            return nil
        }
    }
    
    
    // Delete
    func deletePost(id: String) -> String? {
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            let results = try mainContext.fetch(request)
            
            if let postEntity = results.first {
                
                let videoUrl = postEntity.videoUrl
                mainContext.delete(postEntity)
                try mainContext.save()
                
                return videoUrl
            }
        } catch {
            print("Failed to delete post: \(error)")
        }
        return nil
    }
    
}

