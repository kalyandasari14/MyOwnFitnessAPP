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

    @State private var mealTime = ["Breakfast", "Lunch", "Dinner"]
    @State private var selectedMeal = "Lunch"
    @State private var searchText = ""
    @State private var date = Date.now
    @State private var viewModel = MealDataviewModel()
    @State private var selectedFood: FoodProducts? = nil

    var body: some View {
        NavigationStack {
            List {
                // Meal Type
                Section("Meal Type") {
                    Picker("Meal Type", selection: $selectedMeal) {
                        ForEach(mealTime, id: \.self) { meal in
                            Text(meal)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // Search
                Section("Search Food") {
                    HStack {
                        TextField("e.g. chicken breast", text: $searchText)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                        Button("Search") {
                            Task { 
                                await viewModel.fetchData(foodName: searchText)
                            }
                        }
                        .disabled(searchText.isEmpty || viewModel.isLoading)
                    }
                }

                // Loading
                if viewModel.isLoading {
                    Section {
                        HStack {
                            ProgressView()
                            Text("Searching...")
                                .foregroundStyle(.secondary)
                                .padding(.leading, 8)
                        }
                    }
                }

                // Error
                if let error = viewModel.errorMessage {
                    Section {
                        Text(error)
                            .foregroundStyle(.red)
                    }
                }

                // Results
                if !viewModel.meals.isEmpty {
                    Section("Results") {
                        ForEach(viewModel.meals, id: \.self) { meal in
                            Button {
                                selectedFood = meal
                            } label: {
                                HStack {
                                    Text(meal.description )
                                        .foregroundStyle(.primary)
                                    Spacer()
                                    if selectedFood == meal {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.green)
                                    }
                                }
                            }
                        }
                    }
                }

                // Selected food nutrition
                if let food = selectedFood {
                    Section("Nutrition per 100g") {
                        HStack {
                            Text("Calories")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("\(Int(food.calories)) kcal")
                                .bold()
                        }
                        HStack {
                            Text("Protein")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("\(Int(food.protein))g")
                                .bold()
                                .foregroundStyle(.green)
                        }
                        HStack {
                            Text("Carbs")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("\(Int(food.carbs))g")
                                .bold()
                        }
                        HStack {
                            Text("Fat")
                                .foregroundStyle(.secondary)
                            Spacer()
                            Text("\(Int(food.fats))g")
                                .bold()
                        }
                    }
                }

                // Date
                Section("Date") {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
            }
            .navigationTitle("Add Meal")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveMeal()
                    }
                    .disabled(selectedFood == nil)
                }
            }
        }
    }

    func saveMeal() {
        guard let food = selectedFood else { return }
        let meal = Meal(mealType: selectedMeal,name: food.description, calories: Int(food.calories), protein: Int(food.protein), carbs: Int(food.carbs), fat: Int(food.fats), date: date
        )
        context.insert(meal)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        MealDataView()
            .modelContainer(for: Meal.self, inMemory: true)
    }
}

