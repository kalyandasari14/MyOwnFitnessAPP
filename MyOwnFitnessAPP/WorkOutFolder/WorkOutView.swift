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
    var body: some View {
        Group{
                if exercises.isEmpty{
                    ContentUnavailableView("No Exercises", systemImage: "dumbbell.fill", description: Text("Tap plus on the top to add exercises"))
                }else{
                    List{
                        ForEach(exercises){exercise in
                            NavigationLink(value : exercise){
                                VStack(alignment: .leading){
                                    Text(exercise.workoutName)
                                        .font(.title).foregroundStyle(.primary)
                                    Text("\(exercise.sets.count)")
                                        .font(.caption).foregroundStyle(.secondary)
                                }
                            }
                            
                        }.onDelete(perform: deleteExercise)
                          
                    }  .navigationDestination(for: ExerciseData.self){exercise in
                        ExcerciseDetailView(exercise: exercise)
                    }
                }
        }.navigationTitle("WorkOut App")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingAddExercise = true
                    }label: {
                        Image(systemName: "plus")
                    }
            }
                    
                }
            .sheet(isPresented: $showingAddExercise){
                WorkOutViewData()
            }
            }
    
    func deleteExercise(at offsets: IndexSet){
        for i in offsets{
            context.delete(exercises[i])
        }
    }
        
        
        }
    

#Preview {
    NavigationStack{
        WorkOutView()
            .modelContainer(for: ExerciseData.self, inMemory: true)
    }
}
