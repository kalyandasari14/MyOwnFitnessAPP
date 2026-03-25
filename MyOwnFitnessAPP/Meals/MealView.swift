//
//  MealView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import SwiftUI
import SwiftData

struct MealView: View {
    @Query var meals : [Meal]
    @Environment(\.modelContext) var context
    @State private var showingMealView = false
    @State private var selectedMeal: Meal? = nil
    
    var totalCalories: Int{
        meals.reduce(0){$0 + $1 .calories}
    }
    var body: some View {
        
        Group{
            if meals.isEmpty{
                ContentUnavailableView("NO Meals", systemImage: "carrot", description: Text("Chop Chop Hurry Up!, You cannot build muscles without eating 😄"))
            }else{
                List{
                    Section{
                        HStack{
                            Text("Total Today")
                                .font(.headline)
                            Spacer()
                            Text("\(totalCalories) cal").font(.headline).foregroundStyle(totalCalories < 2000 ? .green : .red)
                            
                        }
                    }
                    
                    
                    ForEach(["Breakfast","Lunch","Dinner"], id: \.self){type in
                        if !mealsFor(type).isEmpty{
                            Section(type){
                                ForEach(mealsFor(type)){meal in
                                    
                                    HStack{
                                        Text(meal.name)
                                            .font(.title)
                                            .foregroundStyle(.primary)
                                        Text("\(meal.protein)g protein · \(meal.carbs)g carbs · \(meal.fat)g fat")
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        
                                    }.onTapGesture{
                                        selectedMeal = meal
                                    }
                                    
                                }.onDelete{offsets in
                                    deleteMeal(at: offsets, from: type)
                                    
                                }
                            }
                        }
                    }
                }
            }
        }.navigationTitle("Meals")
            .toolbar{
                ToolbarItem{
                    Button{
                        showingMealView = true
                    }label: {
                        Image(systemName: "plus")
                    }
                }
                
                
            }
            .sheet(isPresented: $showingMealView){
                MealDataView()
            }
            
                .sheet(item: $selectedMeal){meal in
                    NavigationStack{
                        EditMealView(meal: meal)}
            }
        
    }
    func deleteMeal(at offsets: IndexSet, from type: String){
        let filtered = mealsFor(type)
        for i in offsets{
            context.delete(filtered[i])
        }
    }
    
    func mealsFor(_ type: String)->[Meal]{
        meals.filter{$0.mealType == type}
    }
}

#Preview {
    NavigationStack{
        MealView()
        .modelContainer(for: Meal.self, inMemory: true)}
}
