//
//  AuthViewModel\.swift
//  MyOwnFitnessAPP
//
//  Created by kalyan on 3/22/26.
//

import Foundation
import FirebaseAuth
import Observation

@Observable
class AuthViewModel {
    var user: User?
    var isLoggedIn: Bool { user != nil }
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    init() {
        authStateListener = Auth.auth().addStateDidChangeListener { _, user in
            self.user = user
        }
    }
    
    deinit {
        if let listener = authStateListener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
