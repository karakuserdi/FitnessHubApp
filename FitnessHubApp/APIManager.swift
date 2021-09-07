//
//  APIManager.swift
//  FitnessHubApp
//
//  Created by Riza Erdi Karakus on 13.08.2021.
//

import Foundation

public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void){
    if let email = email {
        //Email Log in
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
        
    } else if let username = username {
        print(username)
    }
}
