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
            
            Color.princeYellow.ignoresSafeArea()
            
            VStack(spacing: 20){
                
                Spacer()
                
                Image("onboarder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(30)
                    .padding(.bottom, 10)
                    .shadow(radius: 8)
                
                Text("첫 여행일지를 남겨보세요")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .lineSpacing(10.0)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white.opacity(0.9))
                            .shadow(radius: 3, x: 1, y: 1)
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
