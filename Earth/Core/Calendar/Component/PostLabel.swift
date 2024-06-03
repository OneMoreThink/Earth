//
//  CardView.swift
//  Earth
//
//  Created by 이종선 on 6/3/24.
//

import SwiftUI

struct PostLabel: View {
    
    let post: Post
    
    var body: some View {
        
        VStack(alignment:.center, spacing: 8){
            
            Image(systemName: "star.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.princeYellow)
            
            Text("\(formattedTime(date: post.createdAt))")
                .font(.footnote)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal)
    }
    private func formattedTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        formatter.locale = Locale(identifier: "ko_KR") 
        return formatter.string(from: date)
    }

}
