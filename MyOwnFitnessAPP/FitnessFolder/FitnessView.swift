//
//  FitnessView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/17/26.
//

import SwiftUI
import SwiftData



struct FitnessView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    
    @State private var bodyWeight = 0.0
    @State private var desiredWeight = 0.0
    @State private var date = Date.now
    
    var body: some View {
        NavigationStack{
            Form{
                VStack(spacing: 12){
                    
                    
                    HStack{
                        Text("Bodyweight").font(.title).bold()
                        Spacer()
                    }
                    Divider()
                    TextField("Whats your Bodyweight??", value: $bodyWeight,format: .number).keyboardType(.decimalPad)
                    
                    HStack{
                        Text("Desired weight").font(.title).bold()
                        Spacer()
                    }
                    
                    TextField("whats your desired weight?? ", value: $desiredWeight, format: .number)
                    
                    HStack{
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                    }
                }
            }.navigationTitle("Add Weight")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Save"){
                            saveWeight()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading){
                        Button("Cancel"){
                            dismiss()
                        }
                    }
                }
        }
    }
    func saveWeight(){
        let weight = Bodyweight(bodyweight: bodyWeight, desiredWeight: desiredWeight, date: date)
        context.insert(weight)
        dismiss()
    }
}

#Preview {
    FitnessView()
        .modelContainer(for: Bodyweight.self, inMemory: true)
}
