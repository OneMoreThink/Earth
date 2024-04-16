//
//  TabBarView.swift
//  Earth
//
//  Created by 이종선 on 4/10/24.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedTab: String
    @Namespace var animation
    @Binding var previousTab: String

    var body: some View {
        HStack(spacing:0){
            
            TabBarItem(animation: animation, imageName: "person.crop.rectangle.stack", selectedTab: $selectedTab, previousTab: $previousTab)
            
            plusButton
            
            TabBarItem(animation: animation, imageName: "gearshape", selectedTab: $selectedTab, previousTab: $previousTab)
        }
        .padding(.top)
        .padding(.vertical, -10)
        .background(.white)
        .shadow(color: .black.opacity(0.09), radius: 5, x: 1, y: 1 )
    }
    
    private var plusButton: some View {
        Button(action: {
            withAnimation(.spring()){
                previousTab = selectedTab
                selectedTab = "plus"
            }
            
        }, label: {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.white)
                .padding(20)
                .background(.princeYellow)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
                .shadow(color: .black.opacity(0.05), radius: 5, x: -5, y: -5)
                .overlay(
                    Circle()
                        .stroke(.white, lineWidth: 2)
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                    )
                .padding()
            
        })
        .offset(y: -8)
    }
}

#Preview {
   MainTabView()
}
