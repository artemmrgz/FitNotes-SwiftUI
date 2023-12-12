//
//  AddExerciseView.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 08/12/2023.
//

import SwiftUI

struct AddExerciseView: View {
    @State private var muscleGroup: MuscleGroup = .abs
    @State private var exerciseName = ""
    @State private var isExistingExercisesPresented = false
    @State private var statistics = [Statistics]()
    
    @State private var sets = 1
    @State private var weight = 0
    @State private var reps = 0

    @Environment(\.dismiss) private var dismiss
    
    let columns = [
        GridItem(.flexible(maximum: 65), alignment: .center),
        GridItem(.flexible(maximum: 65), alignment: .center),
        GridItem(.flexible(maximum: 65), alignment: .center),
        GridItem(.flexible(), alignment: .center)
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Muscle Group", selection: $muscleGroup) {
                        ForEach(MuscleGroup.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    
                    HStack(spacing: 20) {
                        TextField("Exercise name", text: $exerciseName)
                            .padding(6)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                        
                        Button {
                            isExistingExercisesPresented.toggle()
                        } label: {
                            VStack {
                                Image(systemName: "clock.arrow.circlepath")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 30)
                                Text("Previous").font(.caption)
                            }
                        }
                    }
                }
                
                Section {
                    LazyVGrid(columns: columns, spacing: 8) {
                        Group {
                            Text("Sets")
                            Text("Weight")
                            Text("Reps")
                            Text("")
                        }
                        .font(.headline)
                        .padding(.bottom, 4)
                        
                        ForEach(statistics, id: \.self) { stat in
                            Text("\(stat.sets)")
                            Text("\(stat.weight)")
                            Text("\(stat.repetitions)")
                            Text("")
                        }
                    }
                    
                    LazyVGrid(columns: columns) {
                        Text("\(sets)")
                        TextField("Weight", value: $weight, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                            .frame(width: 40)
                        TextField("Reps", value: $reps, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .padding(4)
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: 1))
                            .frame(width: 40)
                        Stepper("", value: $sets, in: 1...20)
                    }
                    
                    Button {
                        let stat = Statistics(sets: sets, repetitions: reps, weight: weight)
                        appendStatistic(stat, to: statistics)
                        resetCurrentStatistic()
                    } label: {
                        Label("Add Set", systemImage: "plus")
                    }
                    .padding(10)
                    .frame(maxWidth: 150)
                    .centerHorizontally()
                    .background(Color.blue.opacity(0.1))
                    .foregroundStyle(Color.blue)
                    .clipShape(.rect(cornerRadius: 10))
                }
                
                Button {
                    
                } label: {
                    Text("Save")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
                
            }
            .background(Color.red)
            .fullScreenCover(isPresented: $isExistingExercisesPresented) {
                ExistingExercisesView(exerciseName: $exerciseName, muscleGroup: muscleGroup)
            }
            .navigationTitle("Add Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle")
                }
            }
        }
    }
    
    private func appendStatistic(_ statistic: Statistics, to statistics: [Statistics]) {
        // it's not a pure function because it directly modifies AddExerciseView's statistics array. Find out a correct approach of array update
        
        for idx in 0..<statistics.count {
            if statistics[idx] == statistic {
                self.statistics[idx].sets += statistic.sets
                return
            }
        }
        self.statistics.append(statistic)
    }
    
    private func resetCurrentStatistic() {
        sets = 1
        weight = 0
        reps = 0
    }
}

#Preview {
    AddExerciseView()
}
