//
//  MyOwnFitnessAPPApp.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import SwiftUI
import SwiftData
import FirebaseCore
import GoogleSignIn


@main
struct MyOwnFitnessAPPApp: App {
    
    init(){
        FirebaseApp.configure()
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
              let config = GIDConfiguration(clientID: clientID)
              GIDSignIn.sharedInstance.configuration = config
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [ExerciseData.self,Sets.self,Meal.self,Bodyweight.self])
        }
    }
}
