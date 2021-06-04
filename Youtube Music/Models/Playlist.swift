//
//  Playlist.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/30/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit
import Foundation
import Promises

class Playlist {
    var playlistId: String
    var playlistTitle: String
    var playlistImage: UIImage?
    var playlistAuthor: String
    var playlistCount: Int
    
    init?(playlistId: String, playlistTitle: String, playlistImage: UIImage?, playlistAuthor: String, playlistCount: Int){
        
        if playlistId.isEmpty {
            return nil
        }
        
        self.playlistId = playlistId
        self.playlistTitle = playlistTitle
        self.playlistImage = playlistImage
        self.playlistAuthor = playlistAuthor
        self.playlistCount = playlistCount
    }
    
    static func loadPlaylistsDetail(playlistIds: String) -> Promise<[Playlist]>{
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "Youtube API Key")
        let url = "https://www.googleapis.com/youtube/v3/playlists?part=snippet,contentDetails&maxResults=50&id=\(playlistIds)&key=\(apiKey!)"
        return Promise<[Playlist]> { resolve, reject in
            Auth.playlistList = [Playlist]()
            DispatchQueue.global().async {
                if let response: [String: Any] = try! await(Helpers.getDataFromApi(urlString: url)) as [String: Any] {
                    if let items = response["items"] as? [[String: Any]] {
                        // loop items
                        for item in items {
                            if let snippet = item["snippet"] as? [String: Any] {
                                // load data item
                                let playlistId = item["id"] as! String
                                let playlistCount = (item["contentDetails"] as! [String: Any])["itemCount"] as! Int
                                let playlistTitle = snippet["title"] as! String
                                let playlistAuthor = snippet["channelTitle"] as! String
                                
                                let urlString: String = ((snippet["thumbnails"] as! [String: Any])["high"] as! [String: Any])["url"] as! String
                                let urlImage: URL = URL(string: urlString)!
                                do {
                                    // load image and add playlist
                                    let playlistImage: Data = try Data(contentsOf: urlImage)
                                    if let playlist = Playlist(playlistId: playlistId, playlistTitle: playlistTitle, playlistImage: UIImage(data: playlistImage), playlistAuthor: playlistAuthor, playlistCount: playlistCount) {
                                        Auth.playlistList.append(playlist)
                                    }
                                } catch {
                                    fatalError("Cannot Load Image")
                                }
                            }
                        }
                        resolve(Auth.playlistList)
                    }
                    resolve([Playlist]())
                }
            }
        }
    }
}
