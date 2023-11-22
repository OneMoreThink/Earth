//
//  EndView.swift
//  Earth
//
//  Created by 이종선 on 11/16/23.
//

import SwiftUI

struct EndView: View {
    
    @AppStorage("endDate") var endDate: String = ""
    
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
                
                QuestionForm(question: "지구를 떠나는 마지막날 언제일까요?")
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
                                endDate = dateFormatter.string(from: selectedDate)
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

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView(onboardingState: .constant(.birth))
    }
}
