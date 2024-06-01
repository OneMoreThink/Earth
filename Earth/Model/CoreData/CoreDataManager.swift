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
        
        // MARK: mocking Data 이후 삭제 필요
        createMockData()
    }
    
    // Mock Data for Testing
    func createMockData() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        let mockData = [
            ("2023-05-01", "video1"),
            ("2023-05-02", "video2"),
            ("2023-06-01", "video3"),
            ("2023-06-02", "video4"),
            ("2023-07-01", "video1"),
            ("2023-07-02", "video2")
        ]
        
        for (dateString, videoFileName) in mockData {
            if let date = formatter.date(from: dateString),
               let videoUrl = Bundle.main.url(forResource: videoFileName, withExtension: "mp4") {
                
                let postEntity = PostEntity(context: mainContext)
                postEntity.id = UUID().uuidString
                postEntity.videoUrl = videoUrl.absoluteString
                postEntity.createdAt = date
                
                do {
                    try mainContext.save()
                } catch {
                    print("Failed to save post: \(error)")
                }
            }
        }
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
    
    // fetch Posts by Date
    func fetchPostsByMonthAndYear(date: Date) -> [Post] {
        let request: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()

        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.year = calendar.component(.year, from: date)
        dateComponents.month = calendar.component(.month, from: date)
        
        guard let startDate = calendar.date(from: dateComponents),
              let endDate = calendar.date(byAdding: .month, value: 1, to: startDate) else {
            return []
        }

        let predicate = NSPredicate(format: "createdAt >= %@ AND createdAt < %@", startDate as NSDate, endDate as NSDate)
        request.predicate = predicate

        do {
            let result = try mainContext.fetch(request)
            return result.map { Post.from(entity: $0) }
        } catch {
            print("Failed to fetch posts for specified month: \(error)")
            return []
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

