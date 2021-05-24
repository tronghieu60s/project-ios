//
//  RegisterViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/20/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit
import Promises

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styles
        txtPassword.isSecureTextEntry = true
        txtRePassword.isSecureTextEntry = true
    }
    
    @IBAction func btnMoveLoginAction(_ sender: Any) {
        self.onMoveLogin()
    }
    
    @IBAction func btnMoveHomeAction(_ sender: Any) {
        self.onMoveHome()
    }
    
    @IBAction func btnRegisterAction(_ sender: Any) {
        if txtUsername.text == "" || txtPassword.text == "" || txtRePassword.text == "" {
            return Helpers.showNormalAlert(message: "Các trường nhập vào là bắt buộc. Không được để trống.", view: self)
        }
        
        if txtPassword.text != txtRePassword.text {
            return Helpers.showNormalAlert(message: "Mật khẩu nhập lại không khớp. Vui lòng nhập lại.", view: self)
        }
        
        let username = txtUsername.text!
        let password = txtPassword.text!
        
        DispatchQueue.global().async {
            let getUser: User = try! await(User.getUserByUsername(username: username))
            if getUser.username != nil {
                DispatchQueue.main.async {
                    Helpers.showNormalAlert(message: "Tài khoản đã tồn tại. Vui lòng sử dụng tên khác.", view: self)
                }
            }
            else {
                let createUser: User = try! await(User.createUser(username: username, password: password))
                if createUser.username != nil {
                    DispatchQueue.main.async {
                        Helpers.showNormalAlert(message: "Dăng ký tài khoản thành công.", view: self)
                        self.onResetForm();
                    }
                }
            }
        }
    }
    
    func onResetForm(){
        txtUsername.text = "";
        txtPassword.text = "";
        txtRePassword.text = "";
    }
    
    func onMoveLogin(){
        navigationController?.popViewController(animated: true)
    }
    
    func onMoveHome(){
        let scrHome = storyboard?.instantiateViewController(withIdentifier: "ScreenTabBar") as! UITabBarController
        present(scrHome, animated: true, completion: nil)
    }
}
