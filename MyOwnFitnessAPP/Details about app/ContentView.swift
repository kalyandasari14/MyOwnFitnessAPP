//
//  ContentView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/22/26.
//

import SwiftUI

struct ContentView: View {
    @State private var authViewModel = AuthViewModel()

    var body: some View {
        if authViewModel.isLoggedIn {
            MainTabView()  // your existing TabView
        } else {
            LoginView()
        }
    }
}


#Preview {
    ContentView()
}
