//
//  EarthApp.swift
//  Earth
//
//  Created by 이종선 on 11/14/23.
//

import SwiftUI

@main
struct EarthApp: App {
    
    @AppStorage("onboardDone") var onboardDone : Bool = false
    
    var body: some Scene {
        WindowGroup {
            if onboardDone{
                MainTabView()
            } else {
                OnBoardingView()
            }
        }
    }
}
