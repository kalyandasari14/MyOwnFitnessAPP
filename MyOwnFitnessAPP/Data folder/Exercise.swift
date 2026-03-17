//
//  WorkOutData.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import Foundation
import SwiftData

@Model


class ExerciseData{
    var workoutName: String
    var sets : [Sets]
    
    
   
    
    init(workoutName: String, sets: [Sets]) {
        self.workoutName = workoutName
        self.sets = sets
    }
}

@Model
class Sets{
    var wieght: Int
    var reps : Int
    var date : Date?
    
    
    init( workOutwieght: Int, reps: Int, date: Date? = nil) {
        self.wieght = workOutwieght
        self.reps = reps
        self.date = date
    }
}



@Model
class Meal{
    var name: String
    var calories: Int
    var protein: Int
    var carbs: Int
    var fat: Int
    var date: Date
    
    init(name: String, calories: Int, protein: Int, carbs: Int, fat: Int, date: Date = Date()) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.date = date
    }
}

@Model
class Bodyweight{
    var bodyweight: Double
    var desiredWeight: Double
    var date: Date?
    
    init(bodyweight: Double, desiredWeight: Double, date: Date? = nil) {
        self.bodyweight = bodyweight
        self.desiredWeight = desiredWeight
        self.date = date
    }
}
