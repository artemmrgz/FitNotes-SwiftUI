//
//  FirestoreManager.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 26/11/2023.
//

import Collections
import FirebaseFirestore
import Foundation


@Observable
class FirestoreManager {
    
    var exercises = OrderedDictionary<String, [Exercise]>()
    private let db = Firestore.firestore()
    
    func getExercises(userId: String, name: String?, date: String?,
                      muscleGroup: String?) async {
        
        let exercisesRef = db.collection("users").document(userId).collection("exercises")
        
        var query: Query = exercisesRef
        
        if let name {
            query = query.whereField("name", isEqualTo: name)
        }
        
        if let date {
            query = query.whereField("date", isEqualTo: date)
        }
        
        if let muscleGroup {
            query = query.whereField("muscleGroup", isEqualTo: muscleGroup)
        }
        
        do {
            let snapshot = try await query.getDocuments()
            
            var exses = [Exercise]()
            
            for document in snapshot.documents {
                
                do {
                    let exercise = try document.data(as: Exercise.self)
                    exses.append(exercise)
                } catch {
                    print(error)
                }
            }
            
            self.exercises = sortByMuscleGroup(exses)
            
        } catch {
            print("error", error)
        }
        
        func sortByMuscleGroup(_ exercises: [Exercise]) -> OrderedDictionary<String, [Exercise]> {
            var exercisesByMuscleGroup = OrderedDictionary<String, [Exercise]>()
            
            for exercise in exercises {
                if var mg = exercisesByMuscleGroup[exercise.muscleGroup] {
                    mg.append(exercise)
                    exercisesByMuscleGroup[exercise.muscleGroup] = mg
                } else {
                    exercisesByMuscleGroup[exercise.muscleGroup] = [exercise]
                }
            }
            return exercisesByMuscleGroup
        }
    }
}
