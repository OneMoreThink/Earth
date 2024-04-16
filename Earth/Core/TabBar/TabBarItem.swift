//
//  TabBarItem.swift
//  Earth
//
//  Created by 이종선 on 4/10/24.
//

import SwiftUI

struct TabBarItem: View {
    
    var animation: Namespace.ID
    var imageName: String
    @Binding var selectedTab: String
    @Binding var previousTab: String
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()) { 
                previousTab = selectedTab
                selectedTab = imageName
            }
            
        }, label: {
            VStack(spacing: 8){
                Image(systemName: selectedTab == imageName ? imageName + ".fill" : imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 38, height: 38)
                    .foregroundStyle(selectedTab == imageName ? .black.opacity(0.8) : .gray.opacity(0.4))
                
                if selectedTab == imageName {
                    Circle()
                        .fill(.princeYellow)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
        })
    }
}


