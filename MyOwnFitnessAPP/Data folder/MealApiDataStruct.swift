//
//  MealApiDataStruct.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/21/26.
//

import Foundation


// USDA FoodData Central API models
struct FoodResponse: Decodable, Hashable {
    let foods: [FoodProducts]
}


struct FoodProducts: Decodable, Hashable{
    var description: String
    var foodNutrients: [FoodNutrients]
    
    struct FoodNutrients: Decodable, Hashable{
        var nutrientName: String
        var value: Double?
    }
    
    var protein: Double{
        foodNutrients.first(where: { $0.nutrientName == "Protein" })?.value ?? 0
    }
    var calories: Double{
        foodNutrients.first(where: {$0.nutrientName == "Energy"})?.value ?? 0
    }
    
    var fats: Double{
        foodNutrients.first(where: {$0.nutrientName == "Total lipid (fat)"})?.value ?? 0
    }
    
    var carbs: Double{
        foodNutrients.first(where: {$0.nutrientName == "Carbohydrate, by difference"})?.value ?? 0
    }
}

