//
//  WelcomView.swift
//  Earth
//
//  Created by 이종선 on 11/15/23.
//

import SwiftUI

struct WelcomView: View {
    
    @Binding var onboardingState: Onboarding
    @State var isNext = true
    
    var body: some View {
        WalkthroughView(onboardingState: $onboardingState, isNext: $isNext){
           
            
            VStack(spacing: 20){
                    
                    Spacer(minLength: 10)
                    
                    Image("onboarder")
                        .resizable()
                        .frame(height: 400)
                        .aspectRatio(contentMode: .fit)
                        .padding(30)
                        .padding(.bottom, 10)
                        
                    
                    Text("새로운 여행🚀 출발 전에 몇가지만 알려주시겠어요?")
                        .font(.title)
                        .fontWeight(.bold)
                        .kerning(1.3)
                        .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .background(
                           RoundedRectangle(cornerRadius: 10)
                            .fill(.white.opacity(0.5))
                            .shadow(radius: 30, x: 0, y: 20)
                            .padding(-20)
                            .padding(.horizontal)
                                
                        )
                    
                    Spacer()
                    
                    // Minimum spacing when phone is reducing
                    Spacer(minLength: 30)
                    
                }
                .padding()
                
            
        }
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    
    static var previews: some View{
        WelcomView(onboardingState: .constant(.welcome))
    }
}
