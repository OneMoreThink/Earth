//
//  DateView.swift
//  Earth
//
//  Created by 이종선 on 11/15/23.
//

import SwiftUI

struct DateView: View {
    
    @Binding var onboardingState: Onboarding
    @State var isNext = false
    
    var body: some View {
        WalkthroughView(onboardingState: $onboardingState, isNext: $isNext){
            VStack(spacing: 20){
                
                QuestionForm(question: "언제 태어나셨나요?")
                Spacer()
                
                // Minimum spacing when phone is reducing
                Spacer(minLength: 30)
                
            }
            .padding()
            
        }
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(onboardingState: .constant(.birth))
    }
}
