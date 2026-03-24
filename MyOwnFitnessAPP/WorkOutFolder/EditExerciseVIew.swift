//
//  EditExerciseVIew.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/23/26.
//

import SwiftUI
import SwiftData

struct EditExerciseVIew: View {
    @Bindable var exercise: ExerciseData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section("Workout Name") {
                TextField("Change your workout name?", text: $exercise.workoutName)
            }
            
            ForEach(exercise.sets) { set in
                @Bindable var editableSet = set
                
                Section("Set \(editableSet.setNumber)") {
                    LabeledContent("Weight") {
                        TextField("Weight", value: $editableSet.weight, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Reps") {
                        TextField("Reps", value: $editableSet.reps, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
        }
        .navigationTitle("Edit Exercise")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button("Save"){
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    EditExerciseVIew(exercise: ExerciseData(workoutName: "Mikey", sets: [Sets.init(weight: 87, reps: 7, setNumber: 1)])).modelContainer(for: ExerciseData.self, inMemory: true)
}
