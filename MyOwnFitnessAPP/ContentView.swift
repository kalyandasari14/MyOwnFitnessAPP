//
//  ContentView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            NavigationStack{
                WorkOutView()
            }.tabItem{
                Label("Workout", systemImage: "dumbbell.fill")
            }
            
            NavigationStack{
                MealView()
            }.tabItem{
                Label("meals", systemImage: "fork.knife")
            }
            
            NavigationStack{
                FitnessProgressView()
            }.tabItem {
                Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
            }
        }
    }
}
#Preview {
    ContentView()
}
