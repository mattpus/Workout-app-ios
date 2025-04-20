//
//  TasksView.swift
//  exp-tracker-0.1
//
//  Created by Pusiewicz, M. (Mateusz) on 26/09/2024.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    var size: CGSize
    @Binding var currentDate: Date
    /// SwiftData Dynamic Query
    @Query private var tasks: [Task]
    @Query(sort: \Workout.name) private var workouts: [Workout]
    init(size: CGSize, currentDate: Binding<Date>) {
        self._currentDate = currentDate
        self.size = size
        /// Predicate
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: currentDate.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        let predicate = #Predicate<Task> {
            return $0.creationDate >= startOfDate && $0.creationDate < endOfDate
        }
        /// Sorting
        let sortDescriptor = [
            SortDescriptor(\Task.creationDate, order: .forward)
        ]
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 35) {
            ForEach(workouts) { workout in
               WorkoutRowView(workout: workout)
                    .background(alignment: .leading) {
                        if workouts.last?.id != workout.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 8)
                                .padding(.bottom, -35)
                        }
                    }
            }
        }
        .padding([.vertical, .leading], 15)
        .padding(.top, 15)
        .overlay {
            if workouts.isEmpty {
                Text("No Workouts Found")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .frame(width: 150)
                    .offset(y: (size.height - 50) / 2)
            }
        }
    }
}

#Preview {
    ContentView()
}

