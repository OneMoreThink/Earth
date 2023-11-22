//
//  NameView.swift
//  Earth
//
//  Created by 이종선 on 11/15/23.
//

import SwiftUI

struct NameView: View {
    
    @Binding var onboardingState: Onboarding
    @State var isNext: Bool = false
    
    @State private var name: String = ""
    @State private var keyboardHight: CGFloat = 0
    
    var body: some View {
        WalkthroughView(onboardingState: $onboardingState,isNext: $isNext){
            VStack(spacing: 20){
                
                
                    QuestionForm(question: "당신의 이름을 알려주세요")
                    
                    Spacer()
                
                VStack{
                    TextField("여기에 입력해주세요", text: $name)
                        .font(.title2)
                        .padding(.horizontal)
                        .frame(height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white.opacity(0.5))
                                .shadow(radius: 30, x: 0, y: 20)
                                .padding(-30)
                                .padding(.horizontal)
                            
                        )
                        .padding(.horizontal, 20)
                }
                .offset(y: -safeDivision(numerator: keyboardHight, denominator: 2))
                .animation(.spring(), value: keyboardHight)
                .onAppear{
                    self.startListeningToKeyboardEvents()
                }
                .onDisappear{
                    NotificationCenter.default.removeObserver(self)
                }
                
                
                
                    Spacer(minLength: 30)
                    
                }
                .padding()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private func startListeningToKeyboardEvents(){
        
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
                self.keyboardHight = keyboardFrame.height
            }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notification in
            self.keyboardHight = 0
            showNextButton()
        }
    }
    
    private func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),to: nil, from: nil, for: nil)
    }
    
    private func showNextButton(){
        isNext =  !name.isEmpty ? true : false
    }
    
    private func safeDivision(numerator: CGFloat , denominator: CGFloat) -> CGFloat {
        return numerator.isZero ? 0 : numerator / denominator
    }
    
}



struct NameView_Previews: PreviewProvider {
    static var previews: some View{
        NameView(onboardingState: .constant(.name))
    }
}
