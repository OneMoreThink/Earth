//
//  CalendarView.swift
//  Earth
//
//  Created by 이종선 on 5/29/24.
//

import SwiftUI

struct CalendarView: View {
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.gray.opacity(0.09).ignoresSafeArea()
                VStack{
                    CustomDatePicker()
                    Divider()
                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

#Preview {
    CalendarView()
}
