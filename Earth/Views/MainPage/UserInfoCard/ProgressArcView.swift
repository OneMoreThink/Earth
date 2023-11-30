//
//  ProgressView.swift
//  Earth
//
//  Created by 이종선 on 11/24/23.
//

import SwiftUI

struct ProgressArcView: View {
    
    var startDate: Date
    var endDate: Date
        
    private var percentage: Double {
        
        let entire = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        let byToday = Calendar.current.dateComponents([.day], from: startDate, to: Date.now).day ?? 0
    
        return Double(byToday) / Double(entire) * 100
    }
    
    var body: some View {
        Circle()
            .strokeBorder(.white.opacity(0.5),lineWidth: 20)
            .background(
                Circle()
                    .fill(.yellow.opacity(0.2))
                    
                    
            
            )
            .overlay(
                ZStack{
                    
                    Circle()
                        .strokeBorder(.yellow.opacity(0.2),lineWidth: 10)
                   
                    ProgressArc(startDate: startDate, endDate: endDate)
                        .rotation(Angle(degrees: -90))
                        .stroke(.yellow.opacity(0.9), lineWidth: 23)
                        .shadow(color: .yellow, radius: 1, x: 0, y: -2)
                        .blur(radius: 2)
                    
                    Text(String(format: "%.2f", percentage) + "%")
                        .font(.callout)
                        .bold()
                        .foregroundStyle(.black)
                }
            )
            .padding()
    }
}
