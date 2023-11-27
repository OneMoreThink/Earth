//
//  TabBarView.swift
//  Earth
//
//  Created by 이종선 on 11/27/23.
//

import SwiftUI

struct TabBarView: View {
    
    @Binding var selectedTab: String
    
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0){
            
            TabBarButton(animation: animation, image: "house", selectedTab: $selectedTab)
            
            Button(action: {
                withAnimation(.spring()){
                    selectedTab = "plus"
                }
                
            }, label: {
                Image(systemName: "plus")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(20)
                    .background(.yellow)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: 5, y: 5)
                    .shadow(color: .black.opacity(0.05), radius: 5, x: -5, y: -5)
                
            })
            .offset(y: -25)
            
            TabBarButton(animation: animation, image: "play.square.stack", selectedTab: $selectedTab)
            
        }
        .padding(.top)
        .padding(.vertical, -10)
        .background(.white)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
       MainTabView()
    }
}
 

struct TabBarButton: View {
    
    var animation: Namespace.ID
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = image
            }
            
        }, label: {
            
            VStack(spacing: 8){
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
                    .foregroundStyle(selectedTab == image ? .black : .gray.opacity(0.4))
                
                if selectedTab == image{
                    Circle()
                        .fill(.yellow)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
        })
    }
}

