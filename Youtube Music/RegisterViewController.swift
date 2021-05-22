//
//  RegisterViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/20/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import FirebaseDatabase
import UIKit
import Promises

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePassword: UITextField!
    
    
    @IBAction func btnMoveLoginAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMoveHomeAction(_ sender: Any) {
        let scrHome = storyboard?.instantiateViewController(withIdentifier: "ScreenHome") as! HomeViewController
        present(scrHome, animated: true, completion: nil)
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
            let user: User = try! await(User.getUserByUsername(username: username))
            if user.username != nil {
                print(user.password)
//                Helpers.showNormalAlert(message: "Tài khoản đã tồn tại. Vui lòng sử dụng tên khác.", view: self)
            }
            else {
                let object: [String: String] = [
                    "user_password": password
                ]
                Helpers.database.child("users/\(username)").setValue(object)
//               Helpers.showNormalAlert(message: "Dăng ký tài khoản thành công.", view: self)
//                self.onResetForm();
            }
        }
    }
    
    func onResetForm(){
        txtUsername.text = "";
        txtPassword.text = "";
        txtRePassword.text = "";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styles
        txtPassword.isSecureTextEntry = true
        txtRePassword.isSecureTextEntry = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
