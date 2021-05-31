//
//  PlaylistTableViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/30/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit
import Promises

class PlaylistTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Auth.playlistList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "PlaylistTableViewCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? PlaylistTableViewCell {
            let playlist = Auth.playlistList[indexPath.row]
            cell.playlistTitle.text = playlist.playlistTitle
            cell.playlistCount.text = "\(playlist.playlistCount) bài"
            cell.playlistAuthor.text = playlist.playlistAuthor
            cell.playlistImage.image = playlist.playlistImage
            return cell
        } else {
            fatalError("Cannot create the Cell")
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Auth.playlistList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Helpers.showNormalAlert(message: "Đang lấy dữ liệu...", view: self)
        let playlistId = Auth.playlistList[indexPath.row].playlistId
        DispatchQueue.global().async {
            let videoList = try! await(Video.loadPlaylistVideo(playlistId: playlistId))
            DispatchQueue.main.async {
                if videoList.count > 0 {
                    self.onMovePlayer()
                } else {
                    Helpers.showNormalAlert(message: "Playlist không hợp lệ.", view: self)
                }
            }
        }
    }
    
    func onMovePlayer(){
        let scrPlayer = storyboard?.instantiateViewController(withIdentifier: "ScreenPlayer") as! PlayerViewController
        navigationController?.pushViewController(scrPlayer, animated: true)
    }
}
