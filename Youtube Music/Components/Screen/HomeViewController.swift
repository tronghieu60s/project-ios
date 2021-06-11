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
                if videoList.count > 0 {
                    if Auth.userLogged.username != nil {
                        if !Auth.userLogged.playlist.contains(playListId!) {
                            let playListIds = Auth.userLogged.playlist + "\(playListId!),"
                            let _ = try! await(User.updateUserPlaylist(playlist: playListIds))
                            let _ = try! await(Playlist.loadPlaylistsDetail(playlistIds: playListIds))
                            Auth.userLogged.playlist = playListIds
                        }
                    }
                    DispatchQueue.main.async {
                        self.onMovePlayer()
                    }
                } else {
                    DispatchQueue.main.async {
                        Helpers.showNormalAlert(message: "Đường dẫn không hợp lệ. Vui lòng nhập lại.", view: self)
                    }
                }
            DispatchQueue.main.async {
                self.spinnerLoad.stopAnimating()
                self.txtInput.text = ""
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
        
        // Load Playlist
        let _ = Playlist.loadPlaylistsDetail(playlistIds: Auth.userLogged.playlist)
    }
    
}
