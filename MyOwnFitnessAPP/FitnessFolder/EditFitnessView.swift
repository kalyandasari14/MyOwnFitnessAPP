//
//  EditFitnessView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/24/26.
//

import SwiftUI

struct EditFitnessView: View {
    @Environment(\.dismiss) var dismiss
   @Bindable var bodyWeight: Bodyweight
    var body: some View {
        Form{
            Section("NewGoals"){
                LabeledContent("Bodyweight"){
                    TextField("Your New Body Weight",value: $bodyWeight.bodyweight, format: .number).keyboardType(.decimalPad).foregroundStyle(.secondary).multilineTextAlignment(.trailing)
                }
                LabeledContent("DesiredWeight"){
                    TextField("Your new desired weight", value: $bodyWeight.desiredWeight, format: .number).keyboardType(.decimalPad).foregroundStyle(.secondary).multilineTextAlignment(.trailing)
                }
            }
        }.navigationTitle("Edit your goals")
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
    EditFitnessView(bodyWeight: Bodyweight(bodyweight: 243, desiredWeight: 97))
}
