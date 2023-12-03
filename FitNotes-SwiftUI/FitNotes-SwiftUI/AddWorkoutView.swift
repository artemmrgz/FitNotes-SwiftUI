//
//  AddWorkoutView.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 23/11/2023.
//

import SwiftUI

struct AddWorkoutView: View {
    let columns: [GridItem] = [GridItem(.flexible(), spacing: 16),
                               GridItem(.flexible(), spacing: 16)]

    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    //TODO: navigate to workout creation page
                } label: {
                    Text("Create From Scratch")
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(.blue)
                .clipShape(.rect(cornerRadius: 12))
                .foregroundStyle(Color.white)
                
                HStack {
                    Text("Templates")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        //TODO: navigate to template creation page
                    } label: {
                        Label("Template", systemImage: "plus")
                    }
                    .padding(10)
                    .background(Color.blue.opacity(0.1))
                    .foregroundStyle(Color.blue)
                    .clipShape(.rect(cornerRadius: 10))
                }
                .padding(.top, 30)
                
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(temps) { template in
                            let exercises = template.exercises.map { $0.name }
                            TemplateView(name: template.name, exercises: exercises)
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Add Workout")
        }
    }
}

#Preview {
    AddWorkoutView()
}

enum MuscleGroup: String, CaseIterable {
    case abs = "Abs"
    case back = "Back"
    case biceps = "Biceps"
    case chest = "Chest"
    case legs = "Legs"
    case shoulders = "Shoulders"
    case triceps = "Triceps"
}

struct Template: Identifiable {
    var id: UUID = .init()
    let name: String
    let exercises: [Exercise]
}

let temps = [
    Template(name: "Legs and shoulders", exercises: [
        Exercise(name: "Pull up", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)]),
        Exercise(name: "Leg Extension (Machine)", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)]),
        Exercise(name: "Squat", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)])]),
    Template(name: "Legs", exercises: [
        Exercise(name: "Pull up", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)]),
        Exercise(name: "Leg Extension", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)]),
        Exercise(name: "Squat", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)])]),
    Template(name: "Legs", exercises: [
        Exercise(name: "Pull up", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)]),
        Exercise(name: "Leg Extension", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)]),
        Exercise(name: "Squat", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)])]),
    Template(name: "Legs", exercises: [
        Exercise(name: "Pull up", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)]),
        Exercise(name: "Squat", muscleGroup: "Legs", date: "20.01.2023", statistics: [Statistics(sets: 1, repetitions: 1, weight: 1)])])
]
