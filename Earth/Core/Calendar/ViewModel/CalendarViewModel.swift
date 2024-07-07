//
//  CalendarViewModel.swift
//  Earth
//
//  Created by 이종선 on 5/30/24.
//

import Foundation
import SwiftUI
import CoreData


class CalendarViewModel: ObservableObject {
    
    @Published var selectedDate: Date
    @Published var addToMonth: Int
    @Published var postGroupByMonth: PostGroupByMonth?
    let postService: PostService
    
    init(currentDate: Date = Date(), addToMonth: Int = 0, postService: PostService = .shared) {
        self.selectedDate = currentDate
        self.addToMonth = addToMonth
        self.postService = postService
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(didReceiveDataSaveNotification(_:)),
                         name: .didSaveContext, object: nil)
        
        fetchSelectedMonthPosts(date: .now)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didSaveContext, object: nil)
    }
    
    @objc private func didReceiveDataSaveNotification(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo else { return }
        // 새로운 일기를 작성했을 때는 오늘이 있는 날로 달력을 이동한 후에
        // 이번달에 대한 일기 업데이트
        // addToMonth만 옮기면 DatePicker에서 onChange를 통해 달력 업데이트 호출
        if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>, !inserts.isEmpty {
            addToMonth = 0
            fetchSelectedMonthPosts(date: .now)
            
        }
        
        // 일기를 삭제했을 때는 달은 현재 위치를 유지하고 현재 selectedDate에대해 다시 fetch
        if let deletes = userInfo[NSDeletedObjectsKey] as? Set<NSManagedObject>, !deletes.isEmpty {
            fetchSelectedMonthPosts(date: selectedDate)
        }
        
    }
    
    func fetchSelectedMonthPosts(date: Date) {
        fetchPostGroup(for: date) { [weak self] posts in
            DispatchQueue.main.async{
                self?.postGroupByMonth = posts
            }
        }
    }
    
    private func fetchPostGroup(for date: Date, completion: @escaping (PostGroupByMonth) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let newPostGroup = self.postService.fetchPostsGroupedByMonth(date: date)
            completion(newPostGroup)
        }
    }
    
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.addToMonth, to: Date()) else {
            return Date()
        }
        let components = calendar.dateComponents([.year, .month], from: currentMonth)
        return calendar.date(from: components) ?? Date()
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
    
    
}

struct PostGroupByDay: Identifiable {
    var id: String = UUID().uuidString
    var day: Date
    var posts: [Post]
}

struct PostGroupByMonth: Identifiable {
    var id: String = UUID().uuidString
    var month: Date
    var postGroup: [PostGroupByDay]
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

