//
//  CoreDataManager.swift
//  Earth
//
//  Created by 이종선 on 4/14/24.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private let persistentContainer : NSPersistentContainer
    
    private init(){
        persistentContainer = PersistenceController.shared.container
    }
    
    // Create Post
    func createPost(videoUrl: String){
        let context = persistentContainer.viewContext
        
        let postEntity = PostEntity(context: context)
        postEntity.id = UUID().uuidString
        postEntity.videoUrl = videoUrl
        postEntity.createdAt = Date()
        
        do{
            try context.save()
            
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
            let result = try persistentContainer.viewContext.fetch(request)
            return result.map{Post.from(entity: $0)}
        } catch {
        
            print("Failed to fetch posts: \(error)")
                   return []
            
        }
    }
    
    
    // Delete
    func deletePost(id: String) -> String? {
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        do {
            let results = try persistentContainer.viewContext.fetch(request)
            
            if let postEntity = results.first {
                
                let videoUrl = postEntity.videoUrl
                persistentContainer.viewContext.delete(postEntity)
                try persistentContainer.viewContext.save()
                
                return videoUrl
            }
        } catch {
            print("Failed to delete post: \(error)")
        }
        return nil
    }
    
    
}
