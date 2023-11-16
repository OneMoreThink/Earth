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
                BirthView(onboardingState: $onboardingState)
            case .end:
                EndView(onboardingState: $onboardingState)
            case .picture:
                PictureView(onboardingState: $onboardingState)
            case .thanks:
                ThanksView()
            }
            
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    
    static var previews: some View {
        OnBoardingView()
    }
}
