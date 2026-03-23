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
        
        let query = foodName.replacingOccurrences(of: " ", with: "+")
        
        isLoading = true
        errorMessage = nil
        
        let urlString = "https://world.openfoodfacts.org/cgi/search.pl?search_terms=\(query)&json=true&page_size=5&fields=product_name,nutriments"
        
        
        guard let url = URL(string: urlString) else{
            
            isLoading = false
            errorMessage = "Invalid json"
            return
        }
        
        let request = URLRequest(url: url)
        
        do{
            let(data,_) = try await URLSession.shared.data(for: request)
            
             let response = try JSONDecoder().decode(FoodResponse.self, from: data)
            
            meals = response.products
        }catch{
            
            isLoading = false
            errorMessage = "Invalid json"
        }
        isLoading = false
    }
    
}
