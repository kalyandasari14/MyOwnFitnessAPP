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


struct FoodProducts: Decodable, Hashable {
    var description: String?
    var foodNutrients: [FoodNutrient]?
    
    // Computed property to match existing code
    var product_name: String? {
        return description
    }
    
    var nutriments: Nutriments? {
        guard let nutrients = foodNutrients else { return nil }
        
        var energy: Double?
        var protein: Double?
        var carbs: Double?
        var fat: Double?
        
        for nutrient in nutrients {
            switch nutrient.nutrientNumber {
            case "208": // Energy (kcal)
                energy = nutrient.value
            case "203": // Protein
                protein = nutrient.value
            case "205": // Carbohydrates
                carbs = nutrient.value
            case "204": // Fat
                fat = nutrient.value
            default:
                break
            }
        }
        
        return Nutriments(energyKcal: energy, proteins: protein, carbohydrates: carbs, fat: fat)
    }
    
    struct FoodNutrient: Decodable, Hashable {
        var nutrientNumber: String?
        var value: Double?
    }
    
    struct Nutriments: Hashable {
        var energyKcal: Double?
        var proteins: Double?
        var carbohydrates: Double?
        var fat: Double?
    }
}
