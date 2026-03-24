//
//  ContentView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/16/26.
//

import SwiftUI
import FirebaseAuth

struct MainTabView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    
    var body: some View {
        TabView {
            NavigationStack {
                WorkOutView()
            }
            .tabItem {
                Label("Workout", systemImage: "dumbbell.fill")
            }
            
            NavigationStack {
                MealView()
            }
            .tabItem {
                Label("Meals", systemImage: "fork.knife")
            }
            
            NavigationStack {
                FitnessProgressView()
            }
            .tabItem {
                Label("Progress", systemImage: "chart.line.uptrend.xyaxis")
            }
            
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.circle.fill")
            }
        }
    }
}



#Preview {
    MainTabView()
        .environment(AuthViewModel())
}
