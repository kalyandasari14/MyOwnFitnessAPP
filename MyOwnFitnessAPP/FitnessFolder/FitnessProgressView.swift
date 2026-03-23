//
//  ProgressView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import SwiftUI
import SwiftData

struct FitnessProgressView: View {
    @Query var bodyweight:[Bodyweight]
    @Environment(\.modelContext) var context
    @State private var showingFitness = false
    @State private var selectedUnit = "Kg"
    
    var body: some View {
        Group{
            if bodyweight.isEmpty{
                ContentUnavailableView("Add Your weight", systemImage: "figure.strengthtraining.traditional.circle.fill", description: Text("Well lets see your progress "))
            }else{
                List{
                    
                    Picker("Unit", selection: $selectedUnit){
                        Text("kg").tag("kg")
                        Text ("lb").tag("lb")
                    }.pickerStyle(.segmented)
                    
                    
                    
                    
                    ForEach(bodyweight){body in
                        VStack{
                            HStack{
                                Text("Current").foregroundStyle(.secondary)
                                Spacer()
                                
                                Text(formatWeight(body.bodyweight)).bold()
                                
                            }
                            
                            HStack{
                                Text("Goal").foregroundStyle(.secondary)
                                Spacer()
                                
                                Text(formatWeight(body.desiredWeight))  .foregroundStyle(
                                    body.bodyweight <= body.desiredWeight ? .green : .red
                                )
                                
                            }
                            
                            if let date = body.date {
                                Text(date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                        }
                        
                    }.onDelete(perform: deleteWeight)
                    }
            }
        }.navigationTitle("ProgressView")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        showingFitness = true
                    }label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingFitness){
                FitnessView()
            }
    }
    func deleteWeight(at offsets: IndexSet){
        for i in offsets{
            context.delete(bodyweight[i])
        }
    }
    
    func formatWeight(_ kg : Double) -> String{
        let value = selectedUnit == "lb" ? kg * 2.20462 : kg
        return String(format: "%.1f\(selectedUnit)", value)
    }
}

#Preview {
    NavigationStack{
        FitnessProgressView()}.modelContainer(for: Bodyweight.self, inMemory: true)
}
