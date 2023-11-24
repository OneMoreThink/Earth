//
//  ProgressView.swift
//  Earth
//
//  Created by 이종선 on 11/24/23.
//

import SwiftUI

struct ProgressArc: Shape {
    
    let startDate: Date
    let endDate: Date
    
   
    private var degresesPerDay: Double {
        360.0 / Double(daysBetween(start: startDate, end: endDate))
    }
    
    
    private var endAngle: Angle {
        Angle(degrees: Double(daysByNow(start: startDate)) * degresesPerDay - 1.0 )
    }
    

    func daysBetween(start: Date, end: Date) -> Int {
        
        return Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }
    
    func daysByNow(start: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: startDate, to: Date.now).day ?? 0
    }
    
    
    func path(in rect: CGRect) -> Path {
        let diameter = min(rect.size.width, rect.size.height) - 24.0
        let radius = diameter / 2.0
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        return Path{ path in
            path.addArc(center: center, radius: radius, startAngle:Angle(degrees: 1.0), endAngle: endAngle, clockwise: false)
        }
    }
    
}

