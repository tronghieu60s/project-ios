//
//  Helpers.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/21/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import FirebaseDatabase
import UIKit

class Helpers {
    
    static var database: DatabaseReference = Database.database().reference()
    
    static func showNormalAlert(message: String, view: UIViewController){
        let alert:UIAlertController = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        
        let btnOk:UIAlertAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(btnOk)
        view.present(alert, animated: true, completion: nil)
    }
}
