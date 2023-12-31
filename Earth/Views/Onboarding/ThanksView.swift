//
//  ThanksView.swift
//  Earth
//
//  Created by 이종선 on 11/16/23.
//

import SwiftUI

struct ThanksView: View {
    
    let backgroundColor = LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom)
    
    let cardColor = LinearGradient(gradient: Gradient(colors: [.green.opacity(0.5), .blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
    
    let buttonColor = LinearGradient(gradient: Gradient(colors: [.red.opacity(0.9), .yellow.opacity(0.7), .red.opacity(0.9)]), startPoint: .top, endPoint: .bottom)
    
    @AppStorage("userName") var username : String = ""
    @AppStorage("birthDate") var birthDate : String = ""
    @AppStorage("endDate") var endDate: String = ""
    @AppStorage("onboardDone") var onboardDone : Bool = false
    let userImage : UIImage? = UserImageManagers.shared.loadImage(withName: "userImage")
    
    var body: some View {
       
        ZStack{
            VStack{
                Spacer()
                
                VStack(spacing: 8){
                    
                    HStack(alignment: .firstTextBaseline, spacing: 20){
                        Text(" 💫행성 여행 허가증")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .bold()
                        
                        Text("목적지 : 지구 🌏 ")
                            .font(.callout)
                            .bold()
                        
                    }
                    
                    HStack(spacing: 20){
                        
                        if let userImage = userImage{
                            Image(uiImage: userImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                .background(.white)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            
                        } else {
                            Image("onboarder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                .background(.white)
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }
                        
                       
                        Spacer()
                        
                        Text(username)
                            .font(.largeTitle)
                            .bold()
                            
                        
                        Spacer()
                            
                            
                    }
                    .padding(25)
                    
                    VStack(spacing: 20){
                        HStack(alignment: .firstTextBaseline){
                            Text(" 여행 시작일 : ")
                                .font(.title)
                                .bold()
                            Text(birthDate)
                                .font(.title3)
                                .bold()
                            
                        }
                        HStack(alignment: .firstTextBaseline){
                            Text(" 여행 종료일 : ")
                                .font(.title)
                                .bold()
                            Text(endDate)
                                .font(.title3)
                                .bold()
                        }
                    }
                    .padding(20)
    
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(cardColor)
                        .shadow(radius: 30, x: 0, y: 20)
                        .padding(-30)
                        .padding(.horizontal,30)
                    
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white.opacity(0.4), lineWidth: 5)
                        .padding(-30)
                        .padding(.horizontal,30)
                )
                .padding()
                .offset(y: -60)
                
                Text("지구에서는 또 어떤 일들이 생길까요?\n 행복한 여행 되세요 😘")
                    .font(.title2)
                    .bold()
                    .kerning(1.4)
                    .lineSpacing(20)
                    .multilineTextAlignment(.center)
                   
                Spacer()
                
            }
            
            
        }
        .background(backgroundColor)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .overlay(
            Button(action: {
                   onboardDone = true
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


