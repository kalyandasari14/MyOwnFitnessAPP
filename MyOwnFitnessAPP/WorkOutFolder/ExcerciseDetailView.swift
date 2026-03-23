//
//  ExcerciseDetailView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/20/26.
//

import SwiftUI

struct ExcerciseDetailView: View {
    
    let exercise: ExerciseData
    
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
    }
}

#Preview {
    ExcerciseDetailView(exercise: ExerciseData(workoutName: "leg press", sets: [Sets.init(weight: 76, reps: 15, setNumber: 1)]))
}
