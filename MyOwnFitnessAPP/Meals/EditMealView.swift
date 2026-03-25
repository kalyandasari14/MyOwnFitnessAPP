//
//  EditMealView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/24/26.
//

import SwiftUI

struct EditMealView: View {
    @Bindable var meal : Meal
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            Form{
                Section(meal.name){
                    LabeledContent("Name"){
                        TextField("Enter your dish name?", text: $meal.name).foregroundStyle(.primary).multilineTextAlignment(.trailing)
                        
                    }
                }
                Section("Nutrition Info"){
                    
                    LabeledContent("Calories"){
                        TextField("Calories count", value: $meal.calories, format: .number).keyboardType(.numberPad).foregroundStyle(.secondary).multilineTextAlignment(.trailing)
                    }
                    
                    
                    
                    LabeledContent("Protein"){
                        TextField("Protein Quantity", value:$meal.protein, format:.number).foregroundStyle(.secondary).multilineTextAlignment(.trailing).keyboardType(.numberPad)
                    }
                    
                    LabeledContent("Fat"){
                        TextField("Fat contents", value: $meal.fat,format: .number).keyboardType(.numberPad).foregroundStyle(.secondary).multilineTextAlignment(.trailing)
                    }
                    LabeledContent("Carbs"){
                        TextField("Carbs content",value: $meal.carbs,format: .number).keyboardType(.numberPad).foregroundStyle(.secondary).multilineTextAlignment(.trailing)
                    }
                }
                
            }.navigationTitle(meal.name)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button("Save"){
                        dismiss()
                    }
                }
            }
        }
        }
    }


#Preview {
    EditMealView(meal: Meal(mealType:"lunch",name: "Mikey", calories: 87, protein: 78, carbs: 87, fat: 87, date: Date()))
}
