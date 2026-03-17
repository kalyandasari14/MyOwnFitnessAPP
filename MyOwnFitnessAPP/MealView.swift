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
    var body: some View {
        
        Group{
            if meals.isEmpty{
                ContentUnavailableView("NO Meals", systemImage: "carrot", description: Text("Chop Chop Hurry Up!, You cannot build muscles without eating 😄"))
            }else{
                List{
                    ForEach(meals){meal in
                        VStack{
                            Text(meal.name)
                                .font(.title)
                                .foregroundStyle(.primary)
                            Text("\(meal.calories)")
                                .font(.title)
                                .foregroundStyle(.secondary)
                        }
                        
                    }
                }
            }
        }.navigationTitle("Add Meals")
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
        
    }
}

#Preview {
    NavigationStack{
        MealView()
        .modelContainer(for: Meal.self, inMemory: true)}
}
