//
//  VideoTableViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/27/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit

class VideoTableViewController: UITableViewController {
    
    var callback : (()->())?
    
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
        return Player.videoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "VideoTableViewCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? VideoTableViewCell {
            let video = Player.videoList[indexPath.row]
            cell.videoTitle.text = video.videoTitle
            cell.videoAuthor.text = video.videoAuthor
            cell.videoImage.image = video.videoImage
            return cell
        } else {
            fatalError("Cannot create the Cell")
        }
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Player.videoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Player.nowPlaying = indexPath.row
        callback?()
        navigationController?.popViewController(animated: true)
    }
}
