//
//  Video.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/27/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit
import Foundation
import Promises

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
    
    static func loadPlaylistVideo(playlistId: String) -> Promise<[Video]>{
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "Youtube API Key")
        let url = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=\(playlistId)&key=\(apiKey!)"
        return Promise<[Video]> { resolve, reject in
            DispatchQueue.global().async {
                Player.videoList = [Video]()
                Player.nowPlaying = 0
                if let response: [String: Any] = try! await(Helpers.getDataFromApi(urlString: url)) as [String: Any] {
                    if let items = response["items"] as? [[String: Any]] {
                        // loop items
                        for item in items {
                            if let snippet = item["snippet"] as? [String: Any] {
                                // load data item
                                let videoId = (snippet["resourceId"] as! [String: Any])["videoId"] as! String
                                let videoTitle = snippet["title"] as! String
                                let videoAuthor = snippet["videoOwnerChannelTitle"] as! String
                                
                                let urlString: String = ((snippet["thumbnails"] as! [String: Any])["high"] as! [String: Any])["url"] as! String
                                let urlImage: URL = URL(string: urlString)!
                                do {
                                    // load image and add video
                                    let videoImage: Data = try Data(contentsOf: urlImage)
                                    if let video = Video(videoId: videoId, videoTitle: videoTitle, videoImage: UIImage(data: videoImage), videoAuthor: videoAuthor) {
                                        Player.videoList.append(video)
                                    }
                                } catch {
                                    fatalError("Cannot Load Image")
                                }
                            }
                        }
                        resolve(Player.videoList)
                    }
                    resolve([Video]())
                }
            }
        }
    }
}
