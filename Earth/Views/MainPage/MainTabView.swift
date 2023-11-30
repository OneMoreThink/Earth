//
//  MainView.swift
//  Earth
//
//  Created by 이종선 on 11/27/23.
//

import SwiftUI

struct MainTabView: View {
    
    @State var selectedTab: String = "house"
    
    //Hiding TabBar
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        VStack(spacing: 0){
            TabView(selection: $selectedTab){
                
                HomeView()
                    .tag("house")
                
                Color.pink
                    .tag("plus")
                
                Color.blue
                    .tag("play.square.stack")
            }
            
            TabBarView(selectedTab: $selectedTab)
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
