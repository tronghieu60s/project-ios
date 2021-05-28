//
//  Video.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/27/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit
import Foundation

class Video {
    var videoId: String
    var videoTitle: String
    var videoImage: UIImage?
    var videoAuthor: String
    
    init?(videoId: String, videoTitle: String, videoImage: UIImage?, videoAuthor: String){
        
        if videoId.isEmpty {
            return nil
        }
        
        self.videoId = videoId
        self.videoTitle = videoTitle
        self.videoImage = videoImage
        self.videoAuthor = videoAuthor
    }
    
    static func loadPlaylistVideo(playlistId: String){
        let apiKey = "AIzaSyAMThGCJRRf53Pmk2SYJLPXBazsaKQOcZg"
        let url = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playlistId)&key=\(apiKey)"
        Helpers.getDataFromApi(urlString: url)
    }
}
