//
//  EmptyPostView.swift
//  Earth
//
//  Created by 이종선 on 4/15/24.
//

import SwiftUI

struct EmptyPostView: View {
    var body: some View {
        ZStack{
            
            LinearGradient(gradient: Gradient(colors: [Color.yellow.opacity(0.2), Color.yellow.opacity(0.8)]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 20){
                
                Spacer()
                
                Image("onboarder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(30)
                    .padding(.bottom, 10)
                
                Text("지구에서의 첫 여행일지를 남겨보세요")
                    .font(.title)
                    .fontWeight(.bold)
                    .kerning(1.3)
                    .lineSpacing(10.0)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white.opacity(0.5))
                            .shadow(radius: 20, x: 0, y: 10)
                            .padding(-20)
                            .padding(.horizontal)
                        
                    )
                Spacer()
                
                // Minimum spacing when phone is reducing
                Spacer(minLength: 50)
                
            }
            .padding()
        }
    }
}

#Preview {
    EmptyPostView()
}
