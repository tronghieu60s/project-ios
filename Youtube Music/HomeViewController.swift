//
//  ViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/15/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var btnStart: UIButton!
    
    @IBAction func btnStartAction(_ sender: Any) {
        print("test")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styles
        btnStart.layer.cornerRadius = 10
    }
    
}
