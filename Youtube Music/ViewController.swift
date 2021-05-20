//
//  ViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/15/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import FirebaseDatabase
import UIKit

class ViewController: UIViewController {
    
    var database: DatabaseReference!

    @IBOutlet weak var btnStart: UIButton!
    
    @IBAction func btnStartAction(_ sender: Any) {
        database.observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            print("Value: \(value)")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Database.database().reference()
        // Do any additional setup after loading the view.
        btnStart.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert:UIAlertController = UIAlertController(title: "Đăng Nhập", message: "Vui lòng đăng nhập để tiếp tục", preferredStyle: .alert)
        
        alert.addTextField { (txtUsername) in
            txtUsername.placeholder = "Nhập tên người dùng vào đây..."
        }
        
        alert.addTextField { (txtPassword) in
            txtPassword.placeholder = "Nhập mật khẩu vào đây..."
            txtPassword.isSecureTextEntry = true
        }
        
        let btnLogin:UIAlertAction = UIAlertAction(title: "Đăng nhập", style: .default) { (btnLogin) in
            let email: String = alert.textFields![0].text!
            let password: String = alert.textFields![1].text!
            if(email == "tronghieu60s@gmail.com" && password == "123456"){
                
            }
        }
        
        let btnCancel:UIAlertAction = UIAlertAction(title: "Huy", style: .cancel) { (btnCancel) in
            print("huy dang nhap")
        }
        
        alert.addAction(btnLogin)
        alert.addAction(btnCancel)
        
        present(alert, animated: true, completion: nil)
    }
}
