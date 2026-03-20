//
//  MyOwnFitnessAPPApp.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import SwiftUI
import SwiftData


@main
struct MyOwnFitnessAPPApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [ExerciseData.self,Sets.self,Meal.self,Bodyweight.self])
        }
    }
}
