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
class AuthViewModel{
    var user: User? = nil
    var isLoggedIn: Bool{user != nil}
    
    init() {
        Auth.auth().addStateDidChangeListener{_, user in
            self.user = user
            
            
            func signOut(){
                try? Auth.auth().signOut()
            }
        }
    }
}
