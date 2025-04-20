//
//  TaskRowView.swift
//  exp-tracker-0.1
//
//  Created by Pusiewicz, M. (Mateusz) on 26/09/2024.
//

import SwiftUI

struct WorkoutRowView: View {
    @Bindable var workout: Workout
    /// Model Context
    @Environment(\.modelContext) private var context
    /// Direct TextField Binding Making SwiftData to Crash, Hope it will be rectified in the Further Releases!
    /// Workaround use separate @State Variable
    @State private var workoutTitle: String = ""
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
                .overlay {
                    Circle()
                        .foregroundStyle(.clear)
                        .contentShape(.circle)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                workout.isCompleted.toggle()
                            }
                        }
                }
            
            VStack(alignment: .leading, spacing: 8, content: {
                TextField("Workout Title", text: $workoutTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .onSubmit {
                        /// If TaskTitle is Empty, Then Deleting the Task!
                        /// You can remove this feature, if you don't want to delete the Task even after the TextField is Empty
                        if workoutTitle == "" {
                            context.delete(workout)
                            try? context.save()
                        }
                    }
                    .onChange(of: workoutTitle, initial: false) { oldValue, newValue in
                        workout.name = newValue
                    }
                    .onAppear {
                        if workoutTitle.isEmpty {
                            workoutTitle = workout.name
                        }
                    }
                
                Label(workout.creationDate.format("hh:mm a"), systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.black)
            })
            .padding(15)
            .hSpacing(.leading)
            .background(workout.tintColor, in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
            .strikethrough(workout.isCompleted, pattern: .solid, color: .black)
            .contentShape(.contextMenuPreview, .rect(cornerRadius: 15))
            .contextMenu {
                Button("Delete Task", role: .destructive) {
                    /// Deleting Task
                    /// For Context Menu Animation to Finish
                    /// If this causes any Bug, Remove it!
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        context.delete(workout)
                        try? context.save()
                    }
                }
            }
            .offset(y: -8)
        }
    }
    
    var indicatorColor: Color {
        if workout.isCompleted {
            return .green
        }
        
        return workout.creationDate.isSameHour ? .blue : (workout.creationDate.isPast ? .red : .black)
    }
}

#Preview {
    ContentView()
}

