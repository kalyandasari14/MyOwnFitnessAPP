//
//  ProfileView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/23/26.
//

import SwiftUI
import SwiftData
import FirebaseAuth

struct ProfileView: View {
    @Query(sort:\Bodyweight.date,order: .reverse) var bodyWeight: [Bodyweight]
    @Query var exerciseData:[ExerciseData]
    @Environment(AuthViewModel.self) var authViewModel
    @AppStorage("workoutCount") var workoutCount: Int = 4
    
    var body: some View {
        List{
            Section("User Details"){
                HStack{
                    AsyncImage(url: authViewModel.user?.photoURL) { phase in
                        if let image = phase.image{
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .clipShape(.circle)
                        }else if phase.error != nil{
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundStyle(.gray)
                                .frame(width: 100, height: 100)
                                .clipShape(.circle)
                        }else{
                            ProgressView()
                        }
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text(authViewModel.user?.displayName ?? "User")
                        Text( authViewModel.user?.email ?? "Email")}
                }
            }
            Section("Stats"){
               
                if let currentWeight = bodyWeight.first{
                    HStack{
                        Text("Your Current Weight")
                            .foregroundStyle(.primary)
                        Spacer()
                        Text(String(format: "%.2f", currentWeight.bodyweight) )
                            .foregroundStyle(.secondary)
                        
                    }
                }else{
                    Text("No Weight Logged In Yet")
                }
              
                HStack{
                    Text("Total number of workouts :")
                    Spacer()
                    Text("\(exerciseData.count)")
                }
            }
            Section("Goals"){
               
                if let targetWeight = bodyWeight.first{
                    HStack{
                        Text("Target Weight")
                        Spacer()
                        Text(String(format: "%.2f", targetWeight.desiredWeight)).foregroundStyle(.secondary)
                    }
                }
                Stepper("workout days: \(workoutCount)", value: $workoutCount,in: 1...7, step: 1)
                
            }
            
        }.navigationTitle("Profile")
    }
}

#Preview {
    ProfileView()
        .environment(AuthViewModel()).modelContainer(for: Bodyweight.self, inMemory: true)
}
