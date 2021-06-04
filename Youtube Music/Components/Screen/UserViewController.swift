//
//  UserViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/23/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit
import Promises

class UserViewController: UIViewController {
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var txtOldPass: UITextField!
    @IBOutlet weak var txtNewPass: UITextField!
    @IBOutlet weak var txtReNewPass: UITextField!
    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnChangePass: UIButton!
    @IBOutlet weak var lblOldPass: UILabel!
    @IBOutlet weak var lblNewPass: UILabel!
    @IBOutlet weak var lblReNewPass: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resetInterface()
        
        txtOldPass.isSecureTextEntry = true
        txtNewPass.isSecureTextEntry = true
        txtReNewPass.isSecureTextEntry = true
    }

    @IBAction func btnLogoutAction(_ sender: Any) {
        Auth.userLogged = User()
        Auth.playlistList = [Playlist]()
        UserDefaults.standard.set(nil, forKey: "ISUSERLOGGEDIN")
//        let scrLogin = storyboard?.instantiateViewController(withIdentifier: "ScreenLogin") as! UITabBarController
//        present(scrLogin, animated: true, completion: nil)
    }
    
    func resetInterface () {
        if Auth.userLogged.username != nil {
            lblUsername.text = "@\(Auth.userLogged.username!)"
        }
        else {
            lblUsername.text = "Bạn Chưa Đăng Nhập."
            btnLogout.setTitle("Đăng Nhập Ngay", for: .normal)
            txtOldPass.isHidden = true
            txtNewPass.isHidden = true
            txtReNewPass.isHidden = true
            btnChangePass.isHidden = true
            lblOldPass.isHidden = true
            lblNewPass.isHidden = true
            lblReNewPass.isHidden = true
        }
    }
    
    @IBAction func btnChangePassAction(_ sender: Any) {
        let oldPass = txtOldPass.text!
        let newPass = txtNewPass.text!
        let reNewPass = txtReNewPass.text!
        
        let decrypt = try! Helpers.decryptString(encrypted: Auth.userLogged.password, encryptionKey: "ENCRYPTKEY")
        if oldPass != decrypt {
            return Helpers.showNormalAlert(message: "Mật khẩu cũ không chính xác. Vui lòng nhập lại.", view: self)
        }
        
        if newPass != reNewPass {
            return Helpers.showNormalAlert(message: "Mật khẩu nhập lại không khớp. Vui lòng nhập lại.", view: self)
        }
        
        DispatchQueue.global().async {
            if let username: String = Auth.userLogged.username {
                let encrypt = try! Helpers.encryptString(value: newPass, encryptionKey: "ENCRYPTKEY")
                let _ = try! await(User.updateUserPassword(pass: encrypt))
                Auth.userLogged = try! await(User.getUserByUsername(username: username))
                DispatchQueue.main.async {
                    Helpers.showNormalAlert(message: "Thay đổi mật khẩu thành công.", view: self)
                    self.onResetForm()
                }
            }
        }
    }
    
    func onResetForm(){
        txtOldPass.text = "";
        txtNewPass.text = "";
        txtReNewPass.text = "";
    }
}
