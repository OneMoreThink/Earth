//
//  CalendarViewModel.swift
//  Earth
//
//  Created by 이종선 on 5/30/24.
//

import Foundation
import SwiftUI


class CalendarViewModel: ObservableObject {
    
    @Published var selectedDate: Date
    @Published var addToMonth: Int
    @Published var postGroup: [PostGroup] = []
    let postService: PostService
    
    init(currentDate: Date = Date(), addToMonth: Int = 0, postService: PostService = .shared) {
        self.selectedDate = currentDate
        self.addToMonth = addToMonth
        self.postService = postService
        // fetchPostGroups(for: getCurrentMonth())
    }
    
    
    
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func extractYearAndMonth()->[String]{
         
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: self.selectedDate)
        return date.components(separatedBy: " ")
    }
    
    func extractDates() -> [DateValue]{
       
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days =  currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0 ..< firstWeekday - 1{
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        // 3월 15일 -> 4월 15일 addToMonth +1 
        guard let currentMonth = calendar.date(byAdding: .month, value: self.addToMonth, to: Date()) else {
            return Date()
        }
        // 4월 15일 -> 4월 1일
        let components = calendar.dateComponents([.year, .month], from: currentMonth)
        return calendar.date(from: components) ?? Date()
    }

    func incrementMonth() {
        addToMonth += 1
        //fetchPostGroups(for: getCurrentMonth())
    }

    func decrementMonth() {
        addToMonth -= 1
        //fetchPostGroups(for: getCurrentMonth())
    }
    
}

struct PostGroup: Identifiable {
    var id: String = UUID().uuidString
    var date: Date
    var posts: [Post]
}

struct DateValue: Identifiable{
    var id = UUID().uuidString
    var day: Int
    var date: Date
    var weekday: Weekday {
        let calendar = Calendar.current
        let weekdayIndex = calendar.component(.weekday, from: date)
        return Weekday(rawValue: weekdayIndex) ?? .monday
    }
}

enum Weekday: Int, Identifiable, CaseIterable {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var id : Self { self }
    
    var inKo: String {
        switch self {
        case .sunday:
            return "일"
        case .monday:
            return "월"
        case .tuesday:
            return "화"
        case .wednesday:
            return "수"
        case .thursday:
            return "목"
        case .friday:
            return "금"
        case .saturday:
            return "토"
        }
    }
    
    var isWeekend: Bool {
        return self == .sunday || self == .saturday
    }
}
