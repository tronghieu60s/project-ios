//
//  PlaylistTableViewCell.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/30/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var playlistTitle: UILabel!
    @IBOutlet weak var playlistImage: UIImageView!
    @IBOutlet weak var playlistCount: UILabel!
    @IBOutlet weak var playlistAuthor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
