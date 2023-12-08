//
//  WorkoutOverviewView.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 26/11/2023.
//

import Collections
import SwiftUI

struct WorkoutOverviewView: View {
    var exercises: OrderedDictionary<String, [Exercise]>
    
    var body: some View {
        List {
            ForEach(exercises.keys, id: \.self) { key in
                Section(key) {
                    ForEach(exercises[key]!, id: \.self) { exercise in
                        VStack {
                                
                                Text(exercise.name)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                        
                            
                            VStack {
                                ForEach(exercise.statistics, id: \.self) { statistic in
                                    if let weight = statistic.weight {
                                        Text("\(statistic.sets) sets x \(statistic.repetitions) reps x \(weight) kg")
                                    } else {
                                        Text("\(statistic.sets) sets x \(statistic.repetitions) reps")
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .alignmentGuide(.listRowSeparatorLeading) { dimension in
                            dimension[.leading]
                        }
                        .alignmentGuide(.listRowSeparatorTrailing) { dimension in
                            dimension[.trailing]
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    WorkoutOverviewView(exercises: exercises)
}


var exercises: OrderedDictionary = ["Back": [Exercise(name: "Pull-updjhfjdcnxklj jsfhjsd w skiehfueh sjnduehf fjdhfuvc sdefsa", muscleGroup: "Back", date: "20-06-2023", statistics: [Statistics(sets: 2, repetitions: 2, weight: 12), Statistics(sets: 10, repetitions: 12, weight: 120), Statistics(sets: 1, repetitions: 15, weight: 1)]), Exercise(name: "Pull-up", muscleGroup: "Back", date: "20-06-2023", statistics: [Statistics(sets: 2, repetitions: 2, weight: 12), Statistics(sets: 10, repetitions: 12, weight: 120), Statistics(sets: 1, repetitions: 15, weight: 1)])]]


struct CenterHorizontallyModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

extension View {
    
    func centerHorizontally() -> some View {
        modifier(CenterHorizontallyModifier())
    }
}
