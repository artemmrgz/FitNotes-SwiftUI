//
//  HomeView.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 23/11/2023.
//

import SwiftUI

struct HomeView: View {
    @State private var calendarVM = CalendarViewModel()
    @State private var selectedDay: Day = Day(dayOfMonth: "", dayOfWeek: "", dayAsDate: "")
    
    var body: some View {
        VStack {
            Text("Hello, User!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            ScrollViewReader { value in
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(calendarVM.days) { day in
                            Button {
                                selectedDay = day
                            } label: {
                                CalendarCellView(dayOfMonth: day.dayOfMonth, dayOfWeek: day.dayOfWeek)
                            }
                            .background(selectedDay == day ? Color.blue : Color.gray)
                            .foregroundStyle(selectedDay == day ? Color.black : Color.white)
                            .clipShape(.rect(cornerRadius: 15))
                            .id(day.id)
                        }
                    }
                }.onAppear {
                    guard let today = calendarVM.days.last else { return }
                    selectedDay = today
                    
                    withAnimation {
                        value.scrollTo(today.id)
                    }
                }
            }
            
            Button {
                
            } label: {
                Label("Add workout", systemImage: "plus")
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(Color.green)
            .foregroundStyle(Color.black)
            .font(.title2)
            .clipShape(.rect(cornerRadius: 10))
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
