//
//  RegisterViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/20/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import FirebaseDatabase
import UIKit

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
        
        Helpers.database.observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? [String : AnyObject] ?? [:]
            print("Value: \(value)")
        })
        
        print("dang ky")
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
