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
            //coreManager.createPost(videoUrl: videoUrl)
            
            // 달력상에서 여러 날짜에 영상을 넣어보기 위해 randomDate를 이용해 넣기 
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            if let startDate = formatter.date(from: "2024-05-01"), let endDate = formatter.date(from: "2024-07-31") {
                let randomDate = randomDateBetween(start: startDate, end: endDate)
                coreManager.createPost(videoUrl: videoUrl, date: randomDate)
            } else {
                print("Failed to create date range")
            }
            
        }
    }
    
    func randomDateBetween(start: Date, end: Date) -> Date {
        let timeInterval = end.timeIntervalSince(start)
        let randomInterval = TimeInterval.random(in: 0..<timeInterval)
        return start.addingTimeInterval(randomInterval)
    }

    
    func deletePost(post: Post){
        
        if let videoUrl =  coreManager.deletePost(id: post.id){
            fileManager.deleteFile(fileName: videoUrl)
        }
    }
    
}
