//
//  WorkOutViewData.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import SwiftUI
import SwiftData

struct WorkOutViewData: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var workoutName = ""
    @State private var weight = 0
    @State private var reps = 0
    @State private var date = Date.now
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Workout Details"){
                    TextField("What are you working On??", text: $workoutName)
                    
                }
                Section("Lifting Weight"){
                    TextField("How much weight are you lifting??", value: $weight, format: .number).keyboardType(.numberPad)
                }
                

                Section("Sets Count"){
                    TextField("How many reps are you thinking today??", value: $reps, format: .number)
                        .keyboardType(.numberPad)
                }
                
                Section("Date And Time"){
                    DatePicker("Date", selection: $date,displayedComponents: .date)
                }
            }.navigationTitle("Welcome To The Gym ")
                .toolbar{
                    ToolbarItem(placement: .topBarLeading){
                        Button("Cancel"){
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Save"){
                            saveExercise()
                        }.disabled(workoutName.isEmpty)
                    }
                }
        }
    }
    
    func saveExercise(){
        let newSets = Sets(workOutwieght: weight, reps: reps, date: date)
        let exercise = ExerciseData(workoutName: workoutName, sets: [newSets])
        context.insert(exercise)
        dismiss()
    }
}

#Preview {
    WorkOutViewData().modelContainer(for : ExerciseData.self,inMemory: true)
}
