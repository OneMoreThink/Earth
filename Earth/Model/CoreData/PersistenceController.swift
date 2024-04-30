//
//  PersistenceController.swift
//  Earth
//
//  Created by 이종선 on 4/14/24.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
//        Post.mock.map { post in
//            let newEntity = PostEntity(context: viewContext)
//            newEntity.id = post.id
//            newEntity.videoUrl = post.videoUrl
//            newEntity.createdDate = Date()
//        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    
    
    let container: NSPersistentContainer
    
    private init(inMemory: Bool = false) {
        
        self.container = NSPersistentContainer(name: "Earth")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
}
