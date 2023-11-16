//
//  DateView.swift
//  Earth
//
//  Created by 이종선 on 11/15/23.
//

import SwiftUI

struct BirthView: View {
    
    @Binding var onboardingState: Onboarding
    @State var isNext = false
    
    @State var selectedDate: Date = Date()
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일" // Set the format you want
        return formatter
    }
    
    var body: some View {
        WalkthroughView(onboardingState: $onboardingState, isNext: $isNext){
            VStack(spacing: 20){
                
                QuestionForm(question: "🐣언제 태어나셨나요?")
                Spacer()
                
                VStack(spacing: 115){
                    Text(dateFormatter.string(from: selectedDate))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .frame(height: 100)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white.opacity(0.5))
                                .shadow(radius: 30, x: 0, y: 20)
                                .padding(-30)
                                .padding(.horizontal,20)
                            
                        )
                    
                    HStack{
                        
                        DatePicker("", selection: $selectedDate,displayedComponents: [.date])
                            .datePickerStyle(.wheel)
                            .frame(height: 100)
                            .padding(.horizontal, 20)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white.opacity(0.5))
                                    .shadow(radius: 30, x: 0, y: 20)
                                    .padding(-30)
                                    .padding(.horizontal,55)
                                    .padding(.vertical,30)
                                
                            )
                            .onChange(of: selectedDate) {  _ in
                                showNextButton()
                            }
                            
                        
                        
                    }
        
                    HStack{}
                    
                }
                // Minimum spacing when phone is reducing
                Spacer(minLength: 30)
                
            }
            .padding()
            
        }
    }
    
    private func showNextButton(){
        isNext = true
        
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        BirthView(onboardingState: .constant(.birth))
    }
}
