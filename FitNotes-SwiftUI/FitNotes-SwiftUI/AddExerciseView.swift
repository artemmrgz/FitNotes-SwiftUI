//
//  AddExerciseView.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 08/12/2023.
//

import SwiftUI

struct AddExerciseView: View {
    @State var muscleGroup: MuscleGroup = .abs
    @State var exerciseName = ""
    
    @State var sets = 1
    @State var weight = 0
    @State var reps = 0
    
    @State var isShowingSavedExs = false
    
    var statistics = [Statistics(sets: 1, repetitions: 0, weight: 0)]
    
    
    let columns = [
        GridItem(.flexible(maximum: 65), alignment: .center),
        GridItem(.flexible(maximum: 65), alignment: .center),
        GridItem(.flexible(maximum: 65), alignment: .center),
        GridItem(.flexible(), alignment: .center)
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                                withAnimation {
                                    isShowingSavedExs.toggle()
                                }
                                
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
                        LazyVGrid(columns: columns) {
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
                                Text(stat.weight != nil ? "\(stat.weight!)" : "0")
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
                }
                .background(Color.red)
                
                if isShowingSavedExs {
                    ExistingExercisesView(isShowing: $isShowingSavedExs, exerciseName: $exerciseName, muscleGroup: muscleGroup)
                }
            }
            .navigationTitle("Add Exercise")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AddExerciseView()
}
