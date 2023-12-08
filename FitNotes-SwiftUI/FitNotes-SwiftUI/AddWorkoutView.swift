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
    
    @State var model = TemplatesModel()

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
            .onAppear {
                Task {
                    do {
                        try await model.getTemplates(userId: "RWk5R8StQaQ3hgmF6K6JyL4vRZm2")
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    AddWorkoutView()
}
