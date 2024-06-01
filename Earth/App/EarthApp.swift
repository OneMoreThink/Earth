//
//  EarthApp.swift
//  Earth
//
//  Created by 이종선 on 4/9/24.
//

import SwiftUI

@main
struct EarthApp: App {
    
    
    init() {setupInitialSettings()}

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
    
    // 초기 설정을 위한 함수
    private func setupInitialSettings() {
        _ = NotificationCenterManager.shared
        _ = AudioSessionManager.shared
        _ = PersistenceController.shared
        _ = CoreDataManager.shared
        _ = MediaFileManager.shared
        _ = PostService.shared
       }
}
