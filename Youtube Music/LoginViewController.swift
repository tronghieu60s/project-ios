//
//  LoginViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/20/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBAction func btnMoveRegisterAction(_ sender: Any) {
        let scrRegister = storyboard?.instantiateViewController(withIdentifier: "ScreenRegister") as! RegisterViewController
        navigationController?.pushViewController(scrRegister, animated: true)
    }
    
    @IBAction func btnMoveHomeAction(_ sender: Any) {
        let scrHome = storyboard?.instantiateViewController(withIdentifier: "ScreenHome") as! HomeViewController
        present(scrHome, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
