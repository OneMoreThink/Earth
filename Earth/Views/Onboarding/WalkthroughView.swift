//
//  WalkthroughView.swift
//  Earth
//
//  Created by 이종선 on 11/14/23.
//

import SwiftUI

struct WalkthroughView<Content:View>: View {
    
    @Binding var onboardingState: Onboarding
    @Binding var isNext : Bool
    let content: Content
    
    let backgroundColor = LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.5), .purple.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
    
    init(onboardingState: Binding<Onboarding> , isNext: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._onboardingState = onboardingState
        self._isNext = isNext
        self.content = content()
    }
    
    var body: some View {
        ZStack{
            content
                .background(backgroundColor)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        .overlay(
            isNext ? nextButton : nil
            ,alignment: .bottom)
        
    }
    

}

extension WalkthroughView {
    private var nextButton: some View {
        Button(action: {
                onboardingState = onboardingState.next()
        },
               
        label: {
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
                .frame(width: 60, height: 60)
                .background(.white)
                .clipShape(Circle())
            // Circular slider
                .overlay(
                    ZStack{
                        
                        Circle()
                            .stroke(.black.opacity(0.04), lineWidth: 6)
                                                        
                        Circle()
                            .trim(from: 0, to: onboardingState.progress)
                            .stroke(.white, lineWidth: 6)
                            .rotationEffect(.init(degrees: -90))
                    }
                    .padding(-15)
                )
                .offset(y: -30)
            
        })
    }
}


