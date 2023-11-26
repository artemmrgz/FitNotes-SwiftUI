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
                    ForEach(exercises[key]!) { exercise in
                        HStack {
                            Text(exercise.name)
                            Spacer()
                            VStack {
                                ForEach(exercise.statistics) { statistic in
                                    if let weight = statistic.weight {
                                        Text("\(statistic.sets) sets x \(statistic.repetitions) reps x \(weight) kg")
                                    } else {
                                        Text("\(statistic.sets) sets x \(statistic.repetitions) reps")
                                    }
                                }
                            }
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


struct Exercise: Codable, Identifiable {
    var id: UUID = .init()
    let name: String
    let muscleGroup: String
    let date: String
    var statistics: [Statistics]
}

struct Statistics: Codable, Identifiable {
    var id: UUID = .init()
    var sets: Int
    let repetitions: Int
    let weight: Int?
}


var exercises: OrderedDictionary = ["Back": [Exercise(name: "Pull-up", muscleGroup: "Back", date: "20-06-2023", statistics: [Statistics(sets: 2, repetitions: 2, weight: 12), Statistics(sets: 10, repetitions: 12, weight: 120), Statistics(sets: 1, repetitions: 15, weight: 1)]), Exercise(name: "Pull-up", muscleGroup: "Back", date: "20-06-2023", statistics: [Statistics(sets: 2, repetitions: 2, weight: 12), Statistics(sets: 10, repetitions: 12, weight: 120), Statistics(sets: 1, repetitions: 15, weight: 1)])]]
