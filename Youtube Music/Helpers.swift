//
//  Helpers.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/21/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//		

import FirebaseDatabase
import UIKit
import RNCryptor
import Promises

class Helpers {
    
    static var database: DatabaseReference = Database.database().reference()
    
    static func showNormalAlert(message: String, view: UIViewController){
        let alert:UIAlertController = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        
        let btnOk:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(btnOk)
        view.present(alert, animated: true, completion: nil)
    }
    
    static func encryptString(value: String, encryptionKey: String) throws -> String {
        let messageData = value.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        return cipherData.base64EncodedString()
    }
    
    static func decryptString(encrypted: String, encryptionKey: String) throws -> String {
        let encryptedData = Data.init(base64Encoded: encrypted)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
        let decryptedString = String(data: decryptedData, encoding: .utf8)!
        return decryptedString
    }
    
    static func getDataFromApi(urlString: String) -> Promise<[String: Any]> {
        return Promise<[String: Any]> { resolve, reject in
            guard let url = URL(string: urlString) else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if error != nil {
                    print("Error: \(error!)")
                }
                if error == nil, let usableData=data {
                    if let response =  try? JSONSerialization.jsonObject(with: usableData, options:[]) as? [String: Any] {
                        resolve(response)
                    }
                }
            }
            task.resume()
        }
    }
}
