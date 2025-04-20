//
//  AddWorkoutTemplateViewModel.swift
//  exp-tracker-0.1
//
//  Created by Matt on 20/04/2025.
//

import Foundation
import SwiftUI // Needed for Color if used, or other SwiftUI types
import SwiftData // Needed for ModelContext and models

// Replicate the ExerciseTemplate struct here or ensure it's accessible
// If it's only used by the View and ViewModel, defining it here might be okay,
// but ideally, it would be in a shared Models location if used elsewhere.
// For now, let's redefine it here for clarity, assuming it's closely tied to this view's logic.
struct ExerciseTemplate: Identifiable {
    let id = UUID()
    var name: String = ""
    var sets: Int = 3
    var reps: Int = 10
}

@Observable // Use @Observable for automatic conformance to ObservableObject in newer Swift versions
class AddWorkoutTemplateViewModel {
    // MARK: - Published Properties (State)
    var templateName: String = ""
    var exercises: [ExerciseTemplate] = []

    // MARK: - Computed Properties
    var isSaveDisabled: Bool {
        templateName.isEmpty || exercises.isEmpty || exercises.contains { $0.name.isEmpty }
    }

    // MARK: - Dependencies
    private var modelContext: ModelContext

    // MARK: - Initialization
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        // Add one empty exercise row to start with
        // addExercise() // Optionally start with one exercise
    }

    // MARK: - Methods (Logic)

    // Function to add a new blank exercise to the list
    func addExercise() {
        exercises.append(ExerciseTemplate())
    }

    // Function to delete exercises from the list
    func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    // Function to save the workout template
    func saveTemplate() {
        guard !isSaveDisabled else {
            print("Save conditions not met.")
            return
        }

        // 1. Create Exercise objects from ExerciseTemplate data
        let workoutExercises = exercises.map { templateExercise in
            // Assuming Exercise model is accessible here
            Exercise(name: templateExercise.name,
                     repetitions: templateExercise.reps, // Map reps to repetitions
                     sets: templateExercise.sets,
                     weight: 0.0) // Default weight to 0 for template
        }

        // 2. Create the Workout object (acting as a template)
        // Assuming Workout model is accessible here
        let newTemplate = Workout(name: templateName,
                                  duration: 0, // Default duration
                                  exercises: workoutExercises,
                                  creationDate: Date(), // Template creation date
                                  isCompleted: false, // Template is not a completed workout
                                  tint: "TaskColor 1") // Default tint

        // 3. Insert into ModelContext
        modelContext.insert(newTemplate)

        // SwiftData typically saves automatically, but explicit save can be added if needed
        // do {
        //     try modelContext.save()
        //     print("Template '\(templateName)' saved successfully.")
        // } catch {
        //     print("Failed to save template: \(error)")
        //     // Handle error appropriately (e.g., show an alert to the user)
        // }
         print("Template '\(templateName)' inserted into context.")
    }
}
