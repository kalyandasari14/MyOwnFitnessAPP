//
//  ExcerciseDetailView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/20/26.
//

import SwiftUI

struct ExcerciseDetailView: View {
    @State private var showingSheet = false
    var exercise: ExerciseData
    
    var body: some View {
        Form{
           ForEach(exercise.sets){workout in
               
               Section("Sets: \(workout.setNumber)"){
                   HStack{
                       Text("Weight")
                           .foregroundStyle(.secondary)
                       Spacer()
                       
                       Text("\(workout.weight) kg ").bold()
                   }
                   
                   HStack{
                       Text("Reps")
                           .foregroundStyle(.secondary)
                       Spacer()
                       
                       Text("\(workout.reps)").bold().foregroundStyle(workout.reps > 10 ? .green : .red)
                   }
                   
               }
                   
                  
                    
                    
                    if let date  = workout.date{
                        Text("Date: \(date.formatted(date: .abbreviated, time: .omitted))")
                    }
            }
            
        }.navigationTitle(exercise.workoutName)
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Edit"){
                        showingSheet = true
                    }
                }
            }
            .sheet(isPresented: $showingSheet){
                NavigationStack{
                    EditExerciseVIew(exercise: exercise)}
            }
    }
}

#Preview {
    ExcerciseDetailView(exercise: ExerciseData(workoutName: "leg press", sets: [Sets.init(weight: 76, reps: 15, setNumber: 1)]))
}
