//
//  Workout.swift
//  exp-tracker-0.1
//
//  Created by Pusiewicz, M. (Mateusz) on 19/03/2025.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Workout {
    var id = UUID()
    var name: String
    var duration: Int // Duration in minutes
    var exercises: [Exercise]
    var creationDate: Date
    var isCompleted: Bool
    var tint: String
    
    init(name: String,
         duration: Int,
         exercises: [Exercise],
         creationDate: Date,
         isCompleted: Bool,
         tint: String) {
        self.name = name
        self.duration = duration
        self.exercises = exercises
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
    }
    
    func description() -> String {
        let exerciseDescriptions = exercises.map { "\($0.name): \($0.sets) sets of \($0.repetitions) reps at \($0.weight) kg" }.joined(separator: ", ")
        return "\(name) for \(duration) minutes on \(dateFormatter.string(from: creationDate)). Exercises: \(exerciseDescriptions)"
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    var tintColor: Color {
        switch tint {
        case "TaskColor 1": return .taskColor1
        case "TaskColor 2": return .taskColor2
        case "TaskColor 3": return .taskColor3
        case "TaskColor 4": return .taskColor4
        case "TaskColor 5": return .taskColor5
        default: return .black
        }
    }
}
