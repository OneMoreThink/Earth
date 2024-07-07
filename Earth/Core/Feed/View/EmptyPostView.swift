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
                    .padding(.bottom, 8)
                    .shadow(radius: 8)
                
                Text(" + 버튼을 눌러 \n 첫 지구 여행기를 남겨보세요")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white.opacity(0.95))
                            .shadow(radius: 2, x: 1, y: 1)
                            .padding(-16)
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
