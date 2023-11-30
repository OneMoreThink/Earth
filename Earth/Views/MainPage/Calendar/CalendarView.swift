//
//  CalendarView.swift
//  Earth
//
//  Created by 이종선 on 11/28/23.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var selectedMonth: Date = .currentMonth
    
    var body: some View {
       
        Calender()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(.white, lineWidth: 2)
                    .shadow(color: .gray, radius: 2, x: 1, y: 1)
                )
            .padding()
            .padding(.bottom, 10)
        
    }
    
    @ViewBuilder
    func Calender() -> some View {
        VStack(alignment: .leading, spacing: 0){
            
            // Month Section
            Text(currentMonth)
                .font(.system(size: 35))
                .bold()
                .frame(maxWidth: .infinity, alignment: .bottom)
                .overlay(alignment: .topLeading){
                    Text(year)
                        .font(.system(size: 25))
                        .bold()
                        .padding()
                }
                .frame(maxWidth: .infinity, alignment: .bottom)
                .overlay(alignment: .topTrailing){
                    HStack(spacing: 15){
                        Button("",systemImage: "chevron.left"){
                            // Update to Previous Month
                            monthUpdate(false)
                        }
                        .contentShape(.rect)
                        
                        Button("",systemImage: "chevron.right"){
                            // Update to Next Month
                            monthUpdate(true)
                        }
                        .contentShape(.rect)
                    }
                    .foregroundStyle(.black)
                }
                .frame(height: calenderTitleViewHeigt)
            
            // Day Section
            VStack(spacing: 0){
                
                // Day Labels
                HStack(spacing: 0){
                    ForEach(Calendar.current.weekdaySymbols, id: \.self) { symbol in
                        Text(symbol)
                            .font(.caption)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(height: weekLabelHeight, alignment: .bottom)
                
                // Calendar Grid View
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7), spacing: 0, content: {
                    ForEach(selectedMonthDates) { day in
                        Text(day.shortSymbol)
                            .foregroundStyle(day.ignored ? .secondary : .primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .contentShape(.rect)
                        
                    }
                })
                .frame(height: calendarGridHeight)
            }
        }
        .padding(.horizontal, horiaontalPadding)
        .padding(.top, topPadding)
        .padding(.bottom, bottomPadding)
        .background(.blue.opacity(0.01))
    }
    
    // Date Formatter
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: selectedMonth)
    }
    
    // Month Increment/Decrement
    func monthUpdate(_ increment: Bool = true) {
        let calendar = Calendar.current
        guard let month = calendar.date(byAdding: .month, value: increment ? 1 : -1, to: selectedMonth) else {return}
        selectedMonth = month
    }
    
    // Selected Month Dates
    var selectedMonthDates: [Day] {
        return extractDates(selectedMonth)
    }
    
    
    // Current Month String
    var currentMonth: String {
        return format("MMMM")
    }
    
    // Selected Year
    var year: String {
        return format("YYYY")
    }
    
    // Height & Padding
    var calenderTitleViewHeigt: CGFloat {
        return 75.0
    }
    
    var weekLabelHeight: CGFloat {
        return 30.0
    }
    
    var calendarGridHeight: CGFloat {
        return CGFloat(selectedMonthDates.count / 7) * 40
    }
    
    var horiaontalPadding: CGFloat {
        return 15.0
    }
    
    var topPadding: CGFloat {
        return 15.0
    }
    
    var bottomPadding: CGFloat {
        return 5.0
    }
}


extension Date {
    static var currentMonth: Date {
        let calender = Calendar.current
        guard let currentMonth = calender.date(from: Calendar.current.dateComponents([.month, .year], from: .now)) else {
            return .now
        }
        return currentMonth
    }
}

extension View {
    
    /// Extracting Dates for the Given Month
    /// - Parameter month: current month's starting date,
    /// By using that, we can extract the current month's date range
    /// - Returns: current month date range.
    func extractDates(_ month: Date) -> [Day] {
        var days: [Day] = []
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        guard let range = calendar.range(of: .day, in: .month, for: month)?.compactMap({ value -> Date? in
            return calendar.date(byAdding: .day, value: value - 1, to: month)
        })
        else {
            return days
        }
        
        
        // the date is not correctly aligned with the weekday.
        // In order to do that, we need to fine the previous or next-month excess date
        // Using the first weekday's value,
        // We can determine how distant the first day is from Sunday.
        // by looping it in reverse order, we can locaate the prior month's date
        // and mark it as an ignored day.
        
        let firstWeekdDay = calendar.component(.weekday, from: range.first!)
        for index in Array(0..<firstWeekdDay - 1).reversed() {
            guard let date = calendar.date(byAdding: .day, value: -index - 1, to: range.first!) else {return days }
            let shortSymbol = formatter.string(from: date)
            days.append(.init(shortSymbol: shortSymbol, date: date, ignored: true))
        }
        
        range.forEach{ date in
            let shortSymbol = formatter.string(from: date)
            days.append(.init(shortSymbol: shortSymbol, date: date))
            
        }
        
        let lastWeekdDay = 7 - calendar.component(.weekday, from: range.last!)
        
        if lastWeekdDay > 0 {
            for index in 0..<lastWeekdDay {
                guard let date = calendar.date(byAdding: .day, value: index + 1, to: range.last!) else {return days }
                let shortSymbol = formatter.string(from: date)
                days.append(.init(shortSymbol: shortSymbol, date: date, ignored: true))
            }
        }
        
        return days
    }
    
}


struct Day: Identifiable {
    var id: UUID = .init()
    var shortSymbol: String
    var date: Date
    // Previous/ Next Month Excess Dates
    var ignored: Bool = false
}



#Preview {
    CalendarView()
}
