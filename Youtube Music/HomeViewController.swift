//
//  ViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/15/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit
import Promises

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var spinnerLoad: UIActivityIndicatorView!
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var btnStart: UIButton!
    
    @IBAction func btnStartAction(_ sender: Any) {
        spinnerLoad.startAnimating()
        var playListId = txtInput.text
        playListId = playListId?.replacingOccurrences(of: "https://www.youtube.com/playlist?list=", with: "")
        playListId = playListId?.replacingOccurrences(of: "https://youtube.com/playlist?list=", with: "")
        DispatchQueue.global().async {
            let videoList = try! await(Video.loadPlaylistVideo(playlistId: playListId!))
            DispatchQueue.main.async {
                if videoList.count > 0 {
                    self.onMovePlayer()
                } else {
                    Helpers.showNormalAlert(message: "Đường dẫn không hợp lệ. Vui lòng nhập lại.", view: self)
                }
                self.spinnerLoad.stopAnimating()
            }
        }
    }
    
    func onMovePlayer(){
        let scrPlayer = storyboard?.instantiateViewController(withIdentifier: "ScreenPlayer") as! PlayerViewController
        navigationController?.pushViewController(scrPlayer, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Styles
        btnStart.layer.cornerRadius = 10
    }
    
}
