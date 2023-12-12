//
//  ExistingExercisesView.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 11/12/2023.
//

import SwiftUI

struct ExistingExercisesView: View {
    @Binding var exerciseName: String
    var muscleGroup: MuscleGroup
    
    @Environment(\.exercisesModel) private var model
    @Environment(\.dismiss) private var dismiss
    @State private var exercises = [String]()
    @State private var hasLoaded = false
   
    var body: some View {
        NavigationStack {
            VStack {
                if hasLoaded {
                    if exercises.isEmpty {
                        VStack {
                            Image(systemName: "questionmark.folder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .padding(.bottom)
                            Text("No exercises found")
                        }
                    } else {
                        List {
                            ForEach(exercises, id: \.self) { exercise in
                                Text(exercise)
                                    .frame(maxWidth: .infinity)
                                    .centerListRowSeparatorModifier()
                                    .onTapGesture {
                                        exerciseName = exercise
                                        dismiss()
                                    }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(.clear)
                    }
                } else {
                    ProgressView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Existing Exercises")
            .navigationBarTitleDisplayMode(.inline)
            .background(.ultraThinMaterial)
            .toolbar {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle")
                }
            }
            .onAppear {
                Task {
                    do {
                        let exercises = try await model.getExistingExerciseNames(for: muscleGroup, userId: "RWk5R8StQaQ3hgmF6K6JyL4vRZm2")
                        self.exercises = exercises
                        self.hasLoaded = true
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ExistingExercisesView(exerciseName: .constant(""), muscleGroup: .abs)
}
