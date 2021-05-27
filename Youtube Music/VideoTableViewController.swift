//
//  VideoTableViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/27/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit

class VideoTableViewController: UITableViewController {
    
    var videoList: [Video] = [Video]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let video: Video = Video(videoId: "eee", videoTitle: "'SÀI GÒN ĐAU LÒNG QUÁ' toàn kỷ niệm chúng ta... | HỨA KIM TUYỀN x HOÀNG DUYÊN (OFFICIAL MV)", videoImage: UIImage(named: "PlayerImage"), videoAuthor: "Hứa Kim Tuyền") {
            videoList += [video]
        }
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videoList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "VideoTableViewCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? VideoTableViewCell {
            let video = videoList[indexPath.row]
            cell.videoTitle.text = video.videoTitle
            cell.videoAuthor.text = video.videoAuthor
            cell.videoImage.image = video.videoImage
            return cell
        } else {
            fatalError("Cannot create the Cell")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            videoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
