//
//  ThanksView.swift
//  Earth
//
//  Created by 이종선 on 11/16/23.
//

import SwiftUI

struct ThanksView: View {
    
    let backgroundColor = LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.5), .purple.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
    
    let cardColor = LinearGradient(gradient: Gradient(colors: [.green.opacity(0.5), .blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
    
    let buttonColor = LinearGradient(gradient: Gradient(colors: [.red.opacity(0.9), .yellow.opacity(0.7), .red.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
       
        ZStack{
            VStack{
                VStack{
                    
                   
                    
                    HStack{
                        Image("onboarder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100,height: 100)
                            .background(.white.opacity(0.5))
                            .clipShape(Circle())
                            .padding(.top, 30)
                            .padding(.leading,10)
                        Spacer(minLength: 5)
                        
                    }
                    .padding(.bottom, 35)
                    
                    Text("여행증 발급이 완료되었어요 \n 지구에서 즐거운 시간 보내세요")
                        .font(.title)
                        .fontWeight(.bold)
                        .kerning(1.2)
                        .lineSpacing(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white.opacity(0.5))
                                .shadow(radius: 30, x: 0, y: 20)
                                .padding(.horizontal, -8)
                                .padding(.horizontal)
                                
                            
                        )
                        
                }
                    
                 
                
                VStack(spacing: 8){
                    
                    HStack(alignment: .firstTextBaseline, spacing: 20){
                        Text(" 💫행성 여행 허가증")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .bold()
                        
                        Text("목적지 : 지구 🌏 ")
                            .font(.callout)
                            .bold()
                        
                    }
                    
                    HStack(spacing: 30){
                        Image("onboarder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .background(.white)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            
                         
                        Spacer()
                        
                        Text("이종선")
                            .font(.largeTitle)
                            .bold()
                            
                        
                        Spacer()
                            
                            
                    }
                    .padding()
                    
                    
        
                    
                    VStack(spacing: 20){
                        Text(" 여행 시작일: 1998. 03. 31 ")
                            .font(.title)
                            .bold()
                            
                        Text(" 여행 종료일: 2098. 03. 31 ")
                            .font(.title)
                            .bold()
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white.opacity(0.3))
                            .shadow(radius: 10, x: 0, y: 10)
                            .padding(.horizontal, -8)
                            .padding(.horizontal)
                            
                        
                    )
                    
                    
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(cardColor)
                        .shadow(radius: 30, x: 0, y: 20)
                        .padding(-30)
                        .padding(.horizontal,30)
                    
                )
                .padding()
                .offset(y: 30)

                
                
                
                
                Spacer()
            }
            
            
        }
        .background(backgroundColor)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .overlay(
            Button(action: {
                   
            },
                   
            label: {
               Text("🚀")
                    .font(.system(size: 40, weight: .semibold))
                    .foregroundStyle(.black)
                    .frame(width: 60, height: 60)
                    .background(.white)
                    .clipShape(Circle())
                // Circular slider
                    .overlay(
                        ZStack{
                            
                            Circle()
                                .stroke(buttonColor, lineWidth: 10)
                                                            
                            Circle()
                                .trim(from: 0, to: 1)
                                .stroke(buttonColor, lineWidth:10)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
                    .offset(y: -30)
                
            })
            , alignment: .bottom)
    }
    
}

struct ThanksView_Previews: PreviewProvider{
    static var previews: some View {
        ThanksView()
    }
}
