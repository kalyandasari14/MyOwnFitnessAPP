//
//  WorkOutView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import SwiftUI
import SwiftData

struct WorkOutView: View {
    @Query var exercises: [ExerciseData]
    @Environment(\.modelContext) var context
    @State private var showingAddExercise = false
    @State private var selectedDate: Date = Date()
    
    
    var todayWorkout: [ExerciseData]{
        exercises.filter{Calendar.current.isDateInToday($0.date)}
    }
    
    var filteredWorkouts: [ExerciseData] {
        exercises.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    var uniqueDates: [Date]{
        let dates = exercises.map {Calendar.current.startOfDay(for: $0.date)}
            return Array(Set(dates)).sorted()
        
    }
    
    
    var body: some View {
        Group {
            if exercises.isEmpty {
                ContentUnavailableView("No Exercises", systemImage: "dumbbell.fill", description: Text("Tap plus on the top to add exercises"))
            } else {
                List {
                    Section("Select Date") {
                        Picker("Workout Date", selection: $selectedDate) {
                            ForEach(uniqueDates, id: \.self) { date in
                                Text(date.formatted(date: .abbreviated, time: .omitted))
                                    .tag(date)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    Section("Exercises for \(selectedDate.formatted(date: .abbreviated, time: .omitted))") {
                        if filteredWorkouts.isEmpty {
                            Text("No exercises for this date")
                                .foregroundStyle(.secondary)
                        } else {
                            ForEach(filteredWorkouts) { exercise in
                                NavigationLink(value: exercise) {
                                    VStack(alignment: .leading) {
                                        Text(exercise.workoutName)
                                            .font(.title).foregroundStyle(.primary)
                                        Text("\(exercise.sets.count) sets")
                                            .font(.caption).foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .onDelete(perform: deleteExercise)
                        }
                    }
                }
                .navigationDestination(for: ExerciseData.self) { exercise in
                    ExcerciseDetailView(exercise: exercise)
                }
            }
        }
        .navigationTitle("WorkOut App")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddExercise = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExercise) {
            WorkOutViewData()
        }
        .onAppear {
            if let firstDate = uniqueDates.first {
                selectedDate = firstDate
            }
        }
    }
    
    func deleteExercise(at offsets: IndexSet) {
        for i in offsets {
            context.delete(filteredWorkouts[i])
        }
    }
    func exercisesFor(_ date: Date) -> [ExerciseData] {
        exercises.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }
}

#Preview {
    NavigationStack{
        WorkOutView()
            .modelContainer(for: ExerciseData.self, inMemory: true)
    }
}
