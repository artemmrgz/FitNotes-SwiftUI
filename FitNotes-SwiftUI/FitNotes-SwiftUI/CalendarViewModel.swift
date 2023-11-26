//
//  CalendarViewModel.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 23/11/2023.
//

import Foundation

class CalendarViewModel {
    enum DayOfWeekFormat: String {
        case EEE
        case EEEE
    }

    enum DayOfMonthFormat: String {
        case d
        case dd
    }

    let dateToday = Date()
    var days: [Day]!

    private var dayOfMonthFormat: DayOfMonthFormat
    private var dayOfWeekFormat: DayOfWeekFormat
    private var dateFormat: String

    init(dayOfMonthFormat: DayOfMonthFormat = .dd,
         dayOfWeekFormat: DayOfWeekFormat = .EEE,
         dateFormat: String = "dd.MM.yyyy") {

        self.dayOfMonthFormat = dayOfMonthFormat
        self.dayOfWeekFormat = dayOfWeekFormat
        self.dateFormat = dateFormat

        getDays(amount: 15)
    }

    func getDays(amount: Int) {
        var innerDays = [Day]()

        for index in -amount...0 {
            innerDays.append(getDate(index: index, currentDate: dateToday))
        }

        days = innerDays
    }

    private func getDate(index: Int, currentDate: Date) -> Day {
        let dayOfMonth = DateFormatter()
        dayOfMonth.dateFormat = dayOfMonthFormat.rawValue

        let dayOfWeek = DateFormatter()
        dayOfWeek.locale = Locale(identifier: "en_US")
        dayOfWeek.dateFormat = dayOfWeekFormat.rawValue

        let fullDate = DateFormatter()
        fullDate.dateFormat = dateFormat

        let date = Calendar.current.date(byAdding: .day, value: index, to: currentDate)!

        return Day(dayOfMonth: dayOfMonth.string(from: date),
                   dayOfWeek: dayOfWeek.string(from: date),
                   dayAsDate: fullDate.string(from: date))
    }
    
    func getTodayDay() -> Day {
        return getDate(index: 0, currentDate: dateToday)
    }
}

struct Day: Identifiable, Equatable, Hashable {
    var id: UUID = .init()
    var dayOfMonth: String
    var dayOfWeek: String
    var dayAsDate: String
}
