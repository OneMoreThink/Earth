//
//  Post.swift
//  Earth
//
//  Created by 이종선 on 4/9/24.
//

import Foundation
import AVKit

struct Post: Identifiable{
    
    let id: String
    var player: AVPlayer?
    var createdAt: Date
    
    static func from(entity: PostEntity) -> Post {
        // 로컬 파일 URL 생성
        let fileURL = URL(fileURLWithPath: entity.videoUrl)

        // AVPlayer 초기화
        let player = AVPlayer(url: fileURL)

        return Post(
            id: entity.id,
            player: player,
            createdAt: entity.createdAt
        )
    }
}

extension Post {
    static var mock: [Post] =
    
    [
        Post(id: UUID().uuidString, player: AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4")!), createdAt: Date()),
        Post(id: UUID().uuidString, player: AVPlayer(url: URL(string:"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4" )!), createdAt: Date()),
        Post(id: UUID().uuidString, player: AVPlayer(url: URL(string:"https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4")!), createdAt: Date()),
        Post(id: UUID().uuidString, player: AVPlayer(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")!), createdAt: Date()),
        
    ]
}
