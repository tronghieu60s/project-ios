//
//  User.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/21/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import Foundation
import Promises

class User {
    var username: String!
    var password: String!
    
    init() {
        
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    static func getUserByUsername(username: String)-> Promise<User> {
        return Promise<User> { resolve, reject in
            var user: User = User()
            Helpers.database.child("users/\(username)").getData { (error, snapshot) in
                if let error = error {
                    print("Error getting data \(error)")
                    reject(error)
                }
                else if snapshot.exists() {
                    if let value: NSObject = snapshot.value as? NSObject {
                        user = User(username: username, password: value.value(forKey: "user_password") as! String)
                        resolve(user)
                    }
                }
                else {
                    resolve(user)
                }
            }
        }
    }
}
