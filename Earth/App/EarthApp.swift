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
        NotificationCenterManager.shared.setupNotificationCenter()
        _ = AudioSessionManager.shared
       }
}
