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
    
    var body: some View {
        Group{
            if bodyweight.isEmpty{
                ContentUnavailableView("Add Your weight", systemImage: "figure.strengthtraining.traditional.circle.fill", description: Text("Well lets see your progress "))
            }else{
                List{
                    ForEach(bodyweight){body in
                        Text("Body Weight")
                        Text("\(body.bodyweight)")
                        Text("\(body.desiredWeight)")
                        
                    }
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
}

#Preview {
    NavigationStack{
        FitnessProgressView()}
}
