//
//  PictureView.swift
//  Earth
//
//  Created by 이종선 on 11/15/23.
//

import SwiftUI

struct PictureView: View {
    
    @Binding var onboardingState: Onboarding
    @State var isNext = false
    
    var body: some View {
        WalkthroughView(onboardingState: $onboardingState, isNext: $isNext){
            VStack(spacing: 20){
                
               QuestionForm(question: "마지막으로 당신의 멋진 모습 보여주세요😀")
                
                
                
                
                
                
                
                
                
                // Minimum spacing when phone is reducing
                Spacer(minLength: 30)
                
                
            }
            .padding()
            
        }
    }
}

struct PictureView_Previews: PreviewProvider{
    static var previews: some View{
        PictureView(onboardingState: .constant(.picture))
    }
}
