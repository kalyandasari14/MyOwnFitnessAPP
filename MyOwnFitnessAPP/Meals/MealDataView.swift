//
//  MealDataView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import SwiftUI
import SwiftData

struct MealDataView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var mealTime = ["Breakfast","Lunch", "Dinner"]
    @State private var selectedMeal = "Lunch"
    
    @State private var name = ""
    @State private var calories = 0
    @State private var protien = 0
    @State private var carbs = 0
    @State private var fat = 0
    @State private var date = Date.now
    
    
    var body: some View {
        NavigationStack{
            List{
                VStack(spacing: 12){
                    
                    Picker("MealGroup", selection: $selectedMeal){
                        ForEach(mealTime, id: \.self){meal in
                            Text(meal)
                        }
                    }
                    
                    Spacer()
                    HStack{
                        Text(selectedMeal).font(.title)
                        Spacer()
                        
                    }
                    
                    TextField("Enter What did you eat??", text: $name).font(.title).foregroundStyle(.primary).bold()
                    HStack{
                        Text("How many Calories You had for \(selectedMeal)??")
                        Spacer()
                    }
                    TextField("HOw many calories", value: $calories,format: .number)
                        .font(.title).foregroundStyle(.secondary).keyboardType(.numberPad)
                    Divider()
                    HStack{
                        Text("How Many Carbs ??")
                        Spacer()
                    }
                    
                    TextField("How Many Carbs", value: $carbs, format: .number).font(.subheadline).foregroundStyle(.secondary).keyboardType(.numberPad)
                    
                    Divider()
                    HStack{
                        Text("Protien")
                        Spacer()
                    }
                    TextField("Get them Muscles", value: $protien, format: .number)
                        .font(.footnote).foregroundStyle(.secondary).keyboardType(.numberPad)
                    Divider()
                    
                    HStack{
                        Text("Whats the Fat content??")
                        Spacer()
                    }
                    
                    TextField("Stay away from it, you dont want to be fat do you??", value: $fat,format: .number).font(.footnote).keyboardType(.numberPad)
                    
                    Divider()
                    
                    HStack{
                        Text("Date")
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: .date)
                    }
                    
                    
                }
            }.navigationTitle("Meal")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing){
                        Button("Save"){
                            saveMeal()
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
    func saveMeal(){
        let meal = Meal(name: name, calories: calories, protein: protien, carbs: carbs, fat: fat)
        context.insert(meal)
        dismiss()
    }
}

#Preview {
    NavigationStack{
        MealDataView()
        .modelContainer(for: Meal.self, inMemory: true)}
}
