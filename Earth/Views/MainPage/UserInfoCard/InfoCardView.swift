//
//  InfoCardView.swift
//  Earth
//
//  Created by 이종선 on 11/24/23.
//

import SwiftUI

struct InfoCardView: View {
    
    let userImage : UIImage? = UserImageManagers.shared.loadImage(withName: "userImage")
    
    @AppStorage("userName") var userName : String = "username"
    @AppStorage("birthDate") var birthDay : String = "1998년 3월 31일"
    @AppStorage("endDate") var endDay: String = "2100년 3월 31일"
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일" // Set the format you want
        return formatter
    }
    
    var birthDate: Date {
        dateFormatter.date(from: birthDay) ?? Date.now
    }
    var endDate: Date {
        dateFormatter.date(from: endDay) ?? Date.now
    }
    var untilNow: String {
       let date = calculateDateDiff(from: birthDate)
    return
        "\(date.year)년 \(date.month)개월 \(date.days)일"
    }
    
    private var percentage: Double {
        
        let entire = Calendar.current.dateComponents([.day], from: birthDate, to: endDate).day ?? 0
        let byToday = Calendar.current.dateComponents([.day], from: birthDate, to: Date.now).day ?? 0
    
        return Double(byToday) / Double(entire)
    }
    
    
    var body: some View {
        ZStack{
            
            Color.blue.opacity(0.03)
                .frame(maxWidth: .infinity, maxHeight: 270)
                .shadow(color: .gray, radius: 1, x: 0, y: 5)
            
            VStack{
                HStack{
                    VStack{
                        if let userImage = userImage {
                            Image(uiImage: userImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Image("idiot")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.white, lineWidth: 1)
                            .frame(width: 150, height: 150)
                            .shadow(color: .gray, radius: 3, x: 0, y: 5)
                    )
                    
                    Spacer()
                    
                    ProgressArcView(startDate: birthDate, endDate: endDate)
                    
                    
                }
              
               
                ZStack{
                    HStack{
                        Text(userName)
                            
                        Text("🌏 생존 : " + untilNow + "째")
                    }
                    .font(.headline)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .padding()
                }
                .overlay(
                    ProgressView(value: percentage)
                        .progressViewStyle(ProgressBar(color: .yellow))
                        .offset(y:20)
                )
                

            }
            .frame(maxWidth: .infinity, maxHeight: 220)
            .padding()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white, lineWidth: 1)
                .shadow(color: .gray, radius: 3, x: 0, y: 5)
            )
            .padding()
            
        
    }
    
    private func calculateDateDiff(from startDate: Date)
    -> (year: Int, month: Int, days: Int){
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: startDate, to: Date.now)
            
            let years = components.year ?? 0
            let months = components.month ?? 0
            let days = components.day ?? 0
        
        return (years, months, days)
    }
    
}



struct InfoCardView_Previews: PreviewProvider {
    static var previews: some View {
        InfoCardView()
            .previewLayout(.sizeThatFits)
    }
}
