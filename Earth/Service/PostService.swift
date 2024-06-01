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
    
    func fetchLatestPost() -> Post? {
        return coreManager.fetchLatestPost()
    }
    
    // 조회한 달의 post전부를 각 날짜별로 그루핑하고 해당 그루핑 내용들을 모두 반환 
    func fetchPostsGroupedByMonth(date: Date) -> PostGroupByMonth {
        let posts = coreManager.fetchPostsByMonthAndYear(date: date)
        let calendar = Calendar.current
        
        var groupedByDay: [Date: [Post]] = [:]
        
        for post in posts {
            let day = calendar.startOfDay(for: post.createdAt)
            if groupedByDay[day] != nil {
                groupedByDay[day]?.append(post)
            } else {
                groupedByDay[day] = [post]
            }
        }
        
        let postGroupsByDay = groupedByDay.map { (day, posts) in
            PostGroupByDay(day: day, posts: posts)
        }.sorted { $0.day < $1.day }
        
        let monthDate = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        return PostGroupByMonth(month: monthDate, postGroup: postGroupsByDay)
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
