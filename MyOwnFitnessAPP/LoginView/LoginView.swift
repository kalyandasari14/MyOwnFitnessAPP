//
//  LoginView.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/22/26.
//
import UIKit
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import FirebaseAuth

struct LoginView: View {
    
    @State private var errorMessage: String? = nil
    @State private var isLoading = false
    
    var body: some View {
        VStack(spacing: 24){
            Spacer()
            
            
            Image(systemName: "figure.strengthtraining.traditional")
                .font(.system(size: 80))
                .foregroundStyle(.green)
            
            
            Text("MyFitness")
                .font(.largeTitle).bold()
            
            
            
            Text("Track Your workouts, meals and progress")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            if let error = errorMessage{
                Text(error).foregroundStyle(.red).font(.caption)
                
                 
            }
            GoogleSignInButton(scheme: .dark, style: .wide){
                signInWithGoogle()
            }.frame(height: 50)
            .padding(.horizontal)
           
           Spacer()
            
        }
    }
    
    private func signInWithGoogle(){
        isLoading = true
        errorMessage = nil
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              
                let rootViewController = windowScene.windows.first? .rootViewController else{
            errorMessage = "cannot find root view controller"
            isLoading = false
            return
        }
        
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
                isLoading = false
                return
            }
            
            
            
            guard let user = result? .user,
                  let idToken = user.idToken? .tokenString else{
                errorMessage = "failed to get user token"
                isLoading = false
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential){result, error in
                isLoading = false
                
                if let error = error{
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
