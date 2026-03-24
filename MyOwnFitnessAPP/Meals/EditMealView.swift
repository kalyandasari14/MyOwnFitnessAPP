//
//  EditMealView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/24/26.
//

import SwiftUI

struct EditMealView: View {
    @Bindable var meal : Meal
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EditMealView(meal: Meal(name: "Mikey", calories: 87, protein: 78, carbs: 87, fat: 87))
}
