//
//  MealDataviewModel.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/21/26.
//

import Foundation
import Observation


@Observable
class MealDataviewModel{
    
    var meals : [FoodProducts] = []
    var isLoading = false
    var errorMessage: String? = nil
    
    
    func fetchData(foodName: String) async {
        let query = foodName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? foodName
        
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(query)&pageSize=5&api_key=2cXbctpmC4BmdrzeJjZbnDRooNmT8YKa1sCNBjTC"
        
        guard let url = URL(string: urlString) else {
            isLoading = false
            errorMessage = "Invalid URL"
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
            let response = try JSONDecoder().decode(FoodResponse.self, from: data)
            meals = response.foods
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
