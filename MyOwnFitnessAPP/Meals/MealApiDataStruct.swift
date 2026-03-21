//
//  MealApiDataStruct.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/21/26.
//

import Foundation


struct FoodResponse: Decodable,Hashable{
    let products: [FoodProducts]
}


struct FoodProducts: Decodable, Hashable{
    var product_name : String?
    var nutriments: Nutriments
    
    struct Nutriments: Decodable, Hashable{
        var energyKcal: Double?
        var proteins: Double?
        var carbohydrates: Double?
        var fat : Double?
        
        
        enum CodingKeys: String, CodingKey {
            case energyKcal = "energy-kcal_100g"
            case proteins = "proteins_100g"
            case carbohydrates = "carbohydrates_100g"
            case fat = "fat_100g"
        }
    }
}
