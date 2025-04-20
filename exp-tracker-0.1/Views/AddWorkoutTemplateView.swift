//
//  AddWorkoutTemplateView.swift
//  exp-tracker-0.1
//
//  Created by Matt on 20/04/2025.
//

import SwiftUI
import SwiftData

struct AddWorkoutTemplateView: View {
    // Inject ModelContext to pass to ViewModel
   
    @Environment(\.dismiss) var dismiss // Environment variable to dismiss the view

    // Instantiate the ViewModel using @State
    // The ViewModel now holds the state and logic
    @State private var viewModel: AddWorkoutTemplateViewModel

    // Initializer to inject the ModelContext into the ViewModel
    init(modelContext: ModelContext) {
        // Note: _viewModel is the State wrapper itself
        _viewModel = State(initialValue: AddWorkoutTemplateViewModel(modelContext: modelContext))
    }

    var body: some View {
        // Use the injected modelContext for the initializer if needed in previews or direct use
        // For previews, a dummy context might be needed.
        // let previewContext = try! ModelContainer(for: Workout.self, Exercise.self).mainContext
        // AddWorkoutTemplateView(modelContext: previewContext)

        NavigationView {
            Form {
                Section(header: Text("Template Details")) {
                    // Bind TextField to ViewModel's property
                    TextField("Template Name", text: $viewModel.templateName)
                }

                Section(header: Text("Exercises")) {
                    // List the exercises from the ViewModel
                    // Use $viewModel.exercises for binding within the ForEach
                    ForEach($viewModel.exercises) { $exercise in
                        
                            TextField("Exercise Name", text: $exercise.name)
                           
                            Stepper("\(exercise.sets) sets", value: $exercise.sets, in: 1...20)
                            Stepper("\(exercise.reps) reps", value: $exercise.reps, in: 1...100)
                    }
                    // Call ViewModel's delete method
                    .onDelete(perform: viewModel.deleteExercise)

                    // Button calls ViewModel's add method
                    Button("Add Exercise") {
                        viewModel.addExercise()
                    }
                }

                Section {
                    Button("Save Template") {
                        // Call ViewModel's save method
                        viewModel.saveTemplate()
                        dismiss() // Dismiss the view after saving attempt
                    }
                    // Use ViewModel's computed property for disabled state
                    .disabled(viewModel.isSaveDisabled)
                }
            }
            .navigationTitle("New Workout Template")
            .navigationBarItems(leading: Button("Cancel") {
                dismiss() // Dismiss the view without saving
            })
        }
    }
}

// Updated Preview Provider to handle ModelContext injection
#Preview {
 
        // Create an in-memory container for preview purposes
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Workout.self, Exercise.self, configurations: config)
            let context = container.mainContext
            // Pass the preview context to the view's initializer
            return AddWorkoutTemplateView(modelContext: context)
        } catch {
            // Handle error gracefully in preview
            return Text("Failed to create preview: \(error.localizedDescription)")
        }
    
}
