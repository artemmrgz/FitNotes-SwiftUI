//
//  CalendarCellView.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 21/11/2023.
//

import SwiftUI

struct CalendarCellView: View {
    let dayOfMonth: String
    let dayOfWeek: String
    
    var body: some View {
        VStack {
            Text(dayOfMonth)
                .font(.headline)
                .fontWeight(.bold)
            Text(dayOfWeek)
                .font(.callout)
        }
        .frame(minWidth: 60, maxHeight: 100)
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    CalendarCellView(dayOfMonth: "21", dayOfWeek: "Wed")
}
