//
//  ViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/15/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnStart: UIButton!
    
    @IBAction func btnStartAction(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        }
        
        let btnLogin:UIAlertAction = UIAlertAction(title: "Đăng nhập", style: .default) { (btnLogin) in
            
        }
        
        let btnCancel:UIAlertAction = UIAlertAction(title: "Huy", style: .cancel) { (btnCancel) in
            
        }
        
        alert.addAction(btnLogin)
        alert.addAction(btnCancel)
        
        present(alert, animated: true, completion: nil)
    }
}
