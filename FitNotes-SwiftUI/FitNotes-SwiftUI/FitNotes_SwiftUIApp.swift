//
//  FitNotes_SwiftUIApp.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 21/11/2023.
//

import SwiftUI
import Firebase

@main
struct FitNotes_SwiftUIApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.exercisesModel, ExercisesModel())
        }
    }
}
