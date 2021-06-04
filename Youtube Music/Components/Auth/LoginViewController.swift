//
//  LoginViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/20/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit
import Promises

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    
    override func viewDidLoad() {
        if let username: String = UserDefaults.standard.object(forKey: "ISUSERLOGGEDIN") as? String {
            DispatchQueue.global().async {
                let getUser: User = try! await(User.getUserByUsername(username: username))
                Auth.userLogged = getUser
                DispatchQueue.main.async {
                    if getUser.username != nil {
                        self.onMoveHome()
                    }
                }
            }
        }
        
        super.viewDidLoad()

        // Styles
        txtPassword.isSecureTextEntry = true
    }
    
    @IBAction func btnMoveRegisterAction(_ sender: Any) {
        self.onMoveRegister()
    }
    
    @IBAction func btnMoveHomeAction(_ sender: Any) {
        self.onMoveHome()
    }
    
    @IBAction func btnLoginAction(_ sender: Any) {
        if txtUsername.text == "" || txtPassword.text == "" {
            return Helpers.showNormalAlert(message: "Các trường nhập vào là bắt buộc. Không được để trống.", view: self)
        }
        
        let username = txtUsername.text!
        let password = txtPassword.text!
        
        DispatchQueue.global().async {
            let getUser: User = try! await(User.getUserByUsername(username: username))
            DispatchQueue.main.async {
                if getUser.username == nil {
                    Helpers.showNormalAlert(message: "Tài khoản hoặc mật khẩu không chính xác. Vui lòng thử lại.", view: self)
                }
                else {
                    let decrypt = try! Helpers.decryptString(encrypted: getUser.password!, encryptionKey: "ENCRYPTKEY")
                    if decrypt != password {
                        Helpers.showNormalAlert(message: "Tài khoản hoặc mật khẩu không chính xác. Vui lòng thử lại.", view: self)
                    }
                    else {
                    UserDefaults.standard.setValue(getUser.username, forKey: "ISUSERLOGGEDIN")
                        Auth.userLogged = getUser
                        self.onMoveHome()
                    }
                }
            }
        }
    }
    
    // Methods
    func onResetForm(){
        txtUsername.text = "";
        txtPassword.text = "";
    }
    
    func onMoveRegister(){
        let scrRegister = storyboard?.instantiateViewController(withIdentifier: "ScreenRegister") as! RegisterViewController
        navigationController?.pushViewController(scrRegister, animated: true)
    }
    
    func onMoveHome(){
        let scrHome = storyboard?.instantiateViewController(withIdentifier: "ScreenTabBar") as! UITabBarController
        present(scrHome, animated: true, completion: nil)
    }
}

