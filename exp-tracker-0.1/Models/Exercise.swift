//
//  Untitled.swift
//  exp-tracker-0.1
//
//  Created by Pusiewicz, M. (Mateusz) on 19/03/2025.
//

import Foundation
import SwiftData

@Model
class Exercise {
    var name: String
    var repetitions: Int
    var sets: Int
    var weight: Double // Weight in kilograms
    
    init(name: String, repetitions: Int, sets: Int, weight: Double) {
        self.name = name
        self.repetitions = repetitions
        self.sets = sets
        self.weight = weight
    }
}
