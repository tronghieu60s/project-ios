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
    var playlist: String = ""
    
    init() {}
    
    init(username: String, password: String, playlist: String) {
        self.username = username
        self.password = password
        self.playlist = playlist
    }
    
    static func updateUserPassword(pass: String)-> Promise<Bool> {
        return Promise<Bool> { resolve, reject in
            if let username: String = UserDefaults.standard.object(forKey: "ISUSERLOGGEDIN") as? String {
                Helpers.database.child("users").child(username).child("user_password").setValue(pass) {
                    error, ref in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                        reject(error)
                    } else {
                        resolve(true)
                    }
                }
            }
        }
    }
    
    static func updateUserPlaylist(playlist: String) -> Promise<Bool> {
        return Promise<Bool> { resolve, reject in
            if let username: String = UserDefaults.standard.object(forKey: "ISUSERLOGGEDIN") as? String{
                Helpers.database.child("users/\(username)").child("user_playlist").setValue(playlist) {
                    error, ref in
                    if let error = error {
                        print("Data could not be saved: \(error).")
                        reject(error)
                    } else {
                        resolve(true)
                    }
                }
            }
        }
    }
    
    static func createUser(username: String, password: String)-> Promise<User> {
        return Promise<User> { resolve, reject in
            let object: [String: String] = [
                "user_password": password,
                "user_playlist": "",
            ]
            Helpers.database.child("users/\(username)").setValue(object) {
                error, ref in
                if let error = error {
                    print("Data could not be saved: \(error).")
                    reject(error)
                } else {
                    resolve(User(username: username, password: password, playlist: ""))
                }
            }
        }
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
                        user = User(username: username, password: value.value(forKey: "user_password") as! String, playlist: value.value(forKey: "user_playlist") as! String)
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
