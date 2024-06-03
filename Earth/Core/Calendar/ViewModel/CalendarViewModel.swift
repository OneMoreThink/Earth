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
    @Published var postGroup: [PostGroupByMonth]
    let postService: PostService
    
    init(currentDate: Date = Date(), addToMonth: Int = 0, postService: PostService = .shared) {
        self.selectedDate = currentDate
        self.addToMonth = addToMonth
        self.postService = postService
        self.postGroup = [PostGroupByMonth(month: .now, postGroup: []),PostGroupByMonth(month: .now, postGroup: []),PostGroupByMonth(month: .now, postGroup: [])]
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(didReceiveDataSaveNotification(_:)),
                         name: .didSaveContext, object: nil)
        fetchInitialPostGroups()
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .didSaveContext, object: nil)
    }
    
    @objc private func didReceiveDataSaveNotification(_ notification: Notification) {
        reloadCalendar()
    }
    
    func reloadCalendar(){
        // 현재달이 postGroup에서 몇번째 Index에 위치했느냐에 따라 다르게 처리
        // -1 ~ 1 까지 -> 이 범위를 초과하는 경우, addToMonth를 변경시키면서 이동하는 과정에서 알아서 업데이트
        guard (-1...1).contains(self.addToMonth) else {return}
        print("reloadCalendar")
        fetchPostGroup(for: Date()) { [weak self] newPostGroup in
            DispatchQueue.main.async {
                switch self?.addToMonth {
                case -1:
                    self?.postGroup.removeLast()
                    self?.postGroup.append(newPostGroup)
                case 0:
                    self?.postGroup.remove(at: 1)
                    self?.postGroup.insert(newPostGroup, at: 1)
                case 1:
                    self?.postGroup.removeFirst()
                    self?.postGroup.insert(newPostGroup, at: 0)
                default:
                    return
                    
                }
            }
        }
        print("updateCalendar")
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
    
    private func fetchInitialPostGroups() {
        self.postGroup.removeAll()
        
        let calendar = Calendar.current
        // 현재 달력이 위치한 달의 1일자 정보
        let currentMonth = getCurrentMonth()
        
        let monthsToFetch = [-1, 0, 1]
        
        for monthOffset in monthsToFetch {
            if let monthDate = calendar.date(byAdding: .month, value: monthOffset, to: currentMonth) {
                fetchPostGroup(for: monthDate) { [weak self] newPostGroup in
                    DispatchQueue.main.async {
                        self?.postGroup.append(newPostGroup)
                    }
                }
            }
        }
    }
    
    private func fetchPostGroup(for date: Date, completion: @escaping (PostGroupByMonth) -> Void) {
        DispatchQueue.global(qos: .default).async {
            let newPostGroup = self.postService.fetchPostsGroupedByMonth(date: date)
            completion(newPostGroup)
        }
    }
    
    func incrementMonth() {
        addToMonth += 1
        
        let calendar = Calendar.current
        let updatedMonth = getCurrentMonth()
        guard let forFetchMonth = calendar.date(byAdding: .month, value: 1, to: updatedMonth) else {
            return
        }
        fetchPostGroup(for: forFetchMonth) { [weak self] newPostGroup in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.postGroup.append(newPostGroup)
                self.postGroup.removeFirst()
            }
        }
    }
    
    func decrementMonth() {
        addToMonth -= 1
        
        let calendar = Calendar.current
        let updatedMonth = getCurrentMonth()
        guard let forFetchMonth = calendar.date(byAdding: .month, value: -1, to: updatedMonth) else {
            return
        }
        fetchPostGroup(for: forFetchMonth) { [weak self] newPostGroup in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.postGroup.insert(newPostGroup, at: 0)
                self.postGroup.removeLast()
            }
        }
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

