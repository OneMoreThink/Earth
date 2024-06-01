//
//  MainTabView.swift
//  Earth
//
//  Created by 이종선 on 4/9/24.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var vm = FeedViewModel()
    @State var showNewPostModal: Bool = false
    @State private var selectedTab: String = "person.crop.rectangle.stack"
    
    var body: some View {
        
        if vm.isLoading{
            ProgressView("기억들을 불러오는 중")
        } else {
            
            VStack(spacing:0){
                
                TabView(selection: $selectedTab){
                    if vm.posts.isEmpty{
                        EmptyPostView()
                            .tag("person.crop.rectangle.stack")
                    } else {
                        FeedView(vm: vm)
                            .ignoresSafeArea()
                            .tag("person.crop.rectangle.stack")
                    }
                    
                    DummyView(showNewPostModal: $showNewPostModal)
                        .tag("plus")
                    
                    CalendarView()
                        .tag("calendar.circle")
                }
                
                TabBarView(selectedTab: $selectedTab)
            }
            .onChange(of: selectedTab, perform: { value in
                if value != "person.crop.rectangle.stack" {
                    vm.isPlaying = false
                }
            })
            .onChange(of: showNewPostModal){ value in
                if !value {
                    selectedTab = "calendar.circle"
                }
                
            }
        }
    }
}

#Preview {
    
    ZStack{
        Color.black.ignoresSafeArea()
        MainTabView()
    }
    
}
