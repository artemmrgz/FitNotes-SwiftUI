//
//  FirestoreManager.swift
//  FitNotes-SwiftUI
//
//  Created by Artem Marhaza on 26/11/2023.
//

import Collections
import FirebaseFirestore
import Foundation

struct Exercise: Codable, Hashable {
    let name: String
    let muscleGroup: String
    let date: String
    var statistics: [Statistics]
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        lhs.name == rhs.name && lhs.muscleGroup == rhs.muscleGroup
    }
}

struct Statistics: Codable, Hashable {
    var sets: Int
    let repetitions: Int
    let weight: Int?
}

struct Template: Identifiable, Codable {
    var id: UUID = .init()
    let name: String
    let exercises: [Exercise]
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

protocol DatabaseManageable {
    func getExercises(userId: String, name: String?, date: String?,
                      muscleGroup: String?) async throws -> [Exercise]
    func getTemplates(userId: String) async throws -> [Template]
}

class FirestoreManager: DatabaseManageable {

    private let db = Firestore.firestore()
    
    func getExercises(userId: String, name: String?, date: String?,
                      muscleGroup: String?) async throws -> [Exercise] {
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
        
        let snapshot = try await query.getDocuments()
            
        var exercises = [Exercise]()
            
        for document in snapshot.documents {
            let exercise = try document.data(as: Exercise.self)
            exercises.append(exercise)
        }
        
        return exercises
    }
    
    func getTemplates(userId: String) async throws -> [Template] {
        let query = db.collection("users").document(userId).collection("templates")
        let snapshot = try await query.getDocuments()
        
//        var templates = [Template]()
//            
//        for document in snapshot.documents {
//            let template = try document.data(as: Template.self)
//            templates.append(template)
//        }
//        
//        return templates
        
        
        return [
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
    }
}

@Observable
class ExercisesModel {
    
    var exercises = OrderedDictionary<String, [Exercise]>()
    var isLoading = false

    private let dbManager: DatabaseManageable
    
    init(dbManager: DatabaseManageable = FirestoreManager()) {
        self.dbManager = dbManager
    }
    
    func getExercises(userId: String, name: String?, date: String?,
                      muscleGroup: String?) async throws {
        
        self.isLoading = true
        
        let allExercises = try await dbManager.getExercises(userId: userId, name: name, date: date, muscleGroup: muscleGroup)
        self.exercises = sortByMuscleGroup(allExercises)
        
        self.isLoading = false
    }
        
    private func sortByMuscleGroup(_ exercises: [Exercise]) -> OrderedDictionary<String, [Exercise]> {
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

@Observable
class TemplatesModel {

    var templates = [Template]()
    var isLoading = false
    
    private let dbManager: DatabaseManageable
    
    init(dbManager: DatabaseManageable = FirestoreManager()) {
        self.dbManager = dbManager
    }
    
    func getTemplates(userId: String) async throws {
        isLoading = true
        
        templates = try await dbManager.getTemplates(userId: userId)
        
        isLoading = false
    }
}

