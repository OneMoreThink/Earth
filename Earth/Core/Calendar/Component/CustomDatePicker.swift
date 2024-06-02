//
//  CustomCalendar.swift
//  Earth
//
//  Created by 이종선 on 5/29/24.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @EnvironmentObject var vm: CalendarViewModel
    
    var body: some View {
            
            VStack(spacing: 10){
                
                header
                weekdays
                let colums = Array(repeating: GridItem(), count: 7)
                LazyVGrid(columns: colums, spacing: 15){
                    ForEach(vm.extractDates()){ value in
                        CardView(value: value)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(LinearGradient(colors: [.yellow, .princeYellow.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .padding(.horizontal, 8)
                                    .opacity(vm.isSameDay(date1: value.date, date2: vm.selectedDate) ? 1 : 0)
                                
                            )
                            .onTapGesture {
                                vm.selectedDate = value.date
                            }
                        
                    }
                }
                
                ScrollView(.vertical) {
                    VStack{
                        let postOfMonth = vm.postGroup[1]
                        
                        if let postOfDay = postOfMonth.postGroup.first(where: { postOfDay in
                            return vm.isSameDay(date1: postOfDay.day, date2: vm.selectedDate)
                        }){
                            ForEach(postOfDay.posts){ post in
                                
                                Text("\(post.createdAt)")
                                
                            }
                        }
                        
                    }
                }
            }
            
        
        .onChange(of: vm.addToMonth){ newValue in
            vm.selectedDate = vm.getCurrentMonth()
        }
        
    }
    
   
    
    private var header: some View {
        
        HStack(spacing: 8){
            
            Text(vm.extractYearAndMonth()[0] + "년")
            Text(vm.extractYearAndMonth()[1])
            
            Button(action: {
                vm.addToMonth = 0
            }, label: {
                Image(systemName: "arrow.circlepath")
                    .padding(.trailing)
            })
            .padding(.leading, 4)
            Spacer()
            
            HStack(spacing: 18){
                Button(action: {
                    vm.decrementMonth()
                }, label: {
                    Image(systemName: "chevron.left")
                })
                
                Button(action: {
                    vm.incrementMonth()
                }, label: {
                    Image(systemName: "chevron.right")
                })
            }
            .padding(.trailing, 16)
        }
        .font(.title2.monospaced())
        .foregroundStyle(.princeYellow)
        .padding(.leading)
        .padding(.bottom)

    }
    
    private var weekdays: some View {
        HStack(spacing: 0){
            ForEach(Weekday.allCases){ day in
                Text(day.inKo)
                    .font(.footnote.monospaced())
                    .fontWeight(day.isWeekend ? .light : .regular)
                    .foregroundStyle(day.isWeekend ? .secondary : .primary)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        
        VStack {
            if value.day != -1 {
                
                let postOfMonth = vm.postGroup[1]
                
                if let postOfDay =
                    postOfMonth.postGroup.first(where: { post in return vm.isSameDay(date1: post.day, date2: value.date)}){
                    Text("\(value.day)")
                        .font(.title3.monospaced())
                        .foregroundStyle(dateForegoundColor(date: value.date))
                        .frame(maxWidth: .infinity)
                    Spacer()
                    
                    Circle()
                        .fill(vm.isSameDay(date1: postOfDay.day, date2: vm.selectedDate) ? .white : .yellow)
                        .frame(width: 8, height: 8)
                } else {
                    Text("\(value.day)")
                        .font(.title3.monospaced())
                        .foregroundStyle(dateForegoundColor(date: value.date))
                        .frame(maxWidth: .infinity)
                }
                
            }
            
        }
        .padding(.vertical, 8)
        .frame(height: 60, alignment: .top)
    }
    
    private func dateForegoundColor(date: Date) -> Color {
        if vm.isSameDay(date1: date, date2: vm.selectedDate){
            return .white
        } else if vm.isSameDay(date1: date, date2: Date()){
            return .blue
        } else {
            return .primary
        }
    }
    
       
}







#Preview {
    CustomDatePicker()
}
