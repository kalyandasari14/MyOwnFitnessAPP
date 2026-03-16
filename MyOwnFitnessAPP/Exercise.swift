//
//  WorkOutData.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import Foundation
import SwiftData

@Model


class Exercise{
    var workoutName : String
    var workoutHours : Int
    var workOutwieght: Int
    var reps : Int
    var sets : Int
    var date : Date?
    
    init(workoutName: String, workoutHours: Int, workOutwieght: Int, reps: Int, sets: Int, date: Date? = nil) {
        self.workoutName = workoutName
        self.workoutHours = workoutHours
        self.workOutwieght = workOutwieght
        self.reps = reps
        self.sets = sets
        self.date = date
    }
}
