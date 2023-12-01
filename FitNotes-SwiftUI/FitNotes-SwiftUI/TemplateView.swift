//
//  TemplateView.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 01/12/2023.
//

import SwiftUI

struct TemplateView: View {
    @State var name: String
    @State var exercises: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.title3)
                .fontWeight(.semibold)
                .lineLimit(2)
            
            let end = min(exercises.count, 3)
            ForEach(0..<end, id: \.self) {
                Text("· \(exercises[$0])")
                    .lineLimit(1)
            }
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .clear]), startPoint: .top, endPoint: .bottom))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 2))
    }
}

#Preview {
    TemplateView(name: "Legs and Shoulders", exercises: ["Pull up", "Leg Extension", "Squat"])
}
