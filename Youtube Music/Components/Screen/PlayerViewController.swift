//
//  PlayerViewController.swift
//  Youtube Music
//
//  Created by Trong Hieu on 5/23/21.
//  Copyright © 2021 Trong Hieu. All rights reserved.
//

import UIKit
import youtube_ios_player_helper_swift
import Promises

class PlayerViewController: UIViewController {
    
    var videoId: String = ""{
        didSet{
            if !videoId.isEmpty{
                loadVideo()
            }
        }
    }

    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var videoAuthor: UILabel!
    @IBOutlet weak var numOfList: UILabel!
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBAction func btnNextAction(_ sender: Any) {
        if(Player.nowPlaying < Player.videoList.count - 1) {
            Player.nowPlaying += 1
        }else {
            Player.nowPlaying = 0
        }
        self.loadDataView()
    }
    @IBAction func btnPreviousAction(_ sender: Any) {
        if(Player.nowPlaying != 0) {
            Player.nowPlaying -= 1
        } else {
            Player.nowPlaying = Player.videoList.count - 1
        }
        self.loadDataView()
    }
    @IBAction func btnListAction(_ sender: Any) {
        let scrPlaylist = storyboard?.instantiateViewController(withIdentifier: "ScreenPlaylistVideo") as! VideoTableViewController
        scrPlaylist.callback = {
            self.loadDataView()
        }
        navigationController?.pushViewController(scrPlaylist, animated: true)
    }
    
    @IBOutlet weak var timeSlider: UISlider!{
        didSet{
            self.timeSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            self.timeSlider.addTarget(self, action: #selector(startEditingSlider), for: .touchDown)
            self.timeSlider.addTarget(self, action: #selector(stopEditingSlider), for: [.touchUpInside, .touchUpOutside])
            self.timeSlider.value = 0.0
        }
    }
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    override func viewDidLoad() {
        self.loadDataView()
        super.viewDidLoad()
        
        videoImage.layer.borderWidth = 1.0
        videoImage.layer.cornerRadius = videoImage.frame.size.width / 2
        videoImage.clipsToBounds = true
    }
    
    private func loadDataView() {
        if Player.videoList.count > 0 {
            let video = Player.videoList[Player.nowPlaying]
            self.numOfList.text = "\(Player.nowPlaying + 1)/\(Player.videoList.count)"
            self.videoId = video.videoId
            self.videoTitle.text = video.videoTitle
            self.videoImage.image = video.videoImage
            self.videoAuthor.text = video.videoAuthor
        }
    }
    
    @IBAction func playStop(sender: UIButton){
        if ytPlayerView.playerState == .playing{
            ytPlayerView.pauseVideo()
            sender.setImage(#imageLiteral(resourceName: "PlayIcon"), for: .normal)
        }else{
            ytPlayerView.playVideo()
            sender.setImage(#imageLiteral(resourceName: "PauseIcon"), for: .normal)
        }
    }
    

    private func loadVideo(){
        let playerVars:[String: Any] = [
            "controls" : "0",
            "showinfo" : "0",
            "autoplay": "0",
            "rel": "0",
            "modestbranding": "0",
            "iv_load_policy" : "3",
            "fs": "0",
            "playsinline" : "1"
        ]
        ytPlayerView.delegate = self as? YTPlayerViewDelegate
        _ = ytPlayerView.load(videoId: videoId, playerVars: playerVars)
        ytPlayerView.isUserInteractionEnabled = false
        updateTime()
    }
    
    @objc func updateTime(){
        let currentTime = ytPlayerView.currentTime
        let duration = Float( ytPlayerView.duration )
        
        let progress = currentTime / duration
        self.timeSlider.value = progress
        self.timeSlider.sendActions(for: .valueChanged)
        
        self.perform(#selector(updateTime), with: nil, afterDelay: 1.0)
    }
    
    // Slider
    @objc func sliderValueChanged(){
        let duration = ytPlayerView.duration
        
        let currentTime = Int(Double(self.timeSlider.value) * duration)
        self.currentTimeLabel.text = self.ytk_secondsToCounter(currentTime)
        
        let timeLeft = Int(duration) - currentTime
        self.remainingTimeLabel.text = "-\(self.ytk_secondsToCounter(timeLeft))"
        
    }
    
    @objc func startEditingSlider(){
        self.ytPlayerView.pauseVideo()
    }
    
    @objc func stopEditingSlider(){
        let duration = Float(ytPlayerView.duration)
        
        let seconds = self.timeSlider.value * duration
        
        self.ytPlayerView.playVideo()
        //        self.playerView.seekTo(seconds: seconds, seekAhead: true)
        self.ytPlayerView.seek(seekToSeconds: seconds, allowSeekAhead: true)
    }
    
    // Methods
    func ytk_secondsToCounter(_ seconds : Int) -> String {
        
        let time = self.secondsToHoursMinutesSeconds(seconds)
        
        let minutesSeconds = "\(self.paddedNumber(time.minutes)):\(self.paddedNumber(time.seconds))"
        
        if(time.hours == 0){
            return minutesSeconds
        }else{
            return "\(self.paddedNumber(time.hours)):\(minutesSeconds)"
        }
        
    }
    
    func secondsToHoursMinutesSeconds (_ seconds : Int) -> (hours : Int, minutes : Int, seconds : Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func paddedNumber(_ number : Int) -> String{
        if(number < 0){
            return "00"
        }else if(number < 10){
            return "0\(number)"
        }else{
            return String(number)
        }
    }

}
