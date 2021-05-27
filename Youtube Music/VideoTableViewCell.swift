//
//  VideoTableViewCell.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/27/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoAuthor: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
