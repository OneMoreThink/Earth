//
//  OnBoardingView.swift
//  Earth
//
//  Created by 이종선 on 11/14/23.
//

import SwiftUI



struct OnBoardingView: View {
    
    @State var onboardingState: Onboarding = .welcome
    
    var body: some View {
        ZStack{
            
            switch onboardingState {
            case .welcome: 
                WelcomView(onboardingState: $onboardingState)
            case .name:
                NameView(onboardingState: $onboardingState)
            case .birth:
                DateView(onboardingState: $onboardingState)
            case .end:
                DateView(onboardingState: $onboardingState)
            case .picture:
                PictureView(onboardingState: $onboardingState)
            }
            
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        OnBoardingView()
    }
}
