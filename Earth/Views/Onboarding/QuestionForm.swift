//
//  QuestionForm.swift
//  Earth
//
//  Created by 이종선 on 11/16/23.
//

import SwiftUI

struct QuestionForm: View {
    
    let question: String
    
    var body: some View {
        VStack{
            HStack{
                Image("onboarder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120,height: 120)
                    .background(.white.opacity(0.5))
                    .clipShape(Circle())
                Spacer(minLength: 5)
                
            }
            .padding(.bottom, 35)
            
            Text(question)
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
                        .padding(-30)
                        .padding(.horizontal)
                    
                )
        }
    }
}



struct QuestionForm_Previews: PreviewProvider {
    static var previews: some View{
        QuestionForm(question: "당신의 이름을 알려주세요")
    }
}
