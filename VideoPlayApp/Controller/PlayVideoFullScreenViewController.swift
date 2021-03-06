//
//  PlayVideoFullScreenViewController.swift
//  VideoPlayApp
//
//  Created by teramoto on 2020/09/03.
//  Copyright © 2020 natsumi. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit

class PlayVideoFullScreenViewController: UIViewController  {
    
    @IBOutlet var playerView: PlayerView!
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var videoTimeSlider: UISlider! {
        didSet {
            // sliderのレイアウト設定
            videoTimeSlider.setThumbImage(UIImage.circle(diameter: 15, color: .lightGray), for: .normal)
        }
    }
    
    var player = AVPlayer()
    var URLstr = ""
    var itemDuration: Double = 0
    var time: CMTime!
    var isNowPlaying: Bool!
    var timeObserverToken: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        if !isNowPlaying {
            playPauseButton.setImage(UIImage(systemName:"pause.fill"), for: .normal)
        } else {
            playPauseButton.setImage(UIImage(systemName:"play.fill"), for: .normal)
        }
        
        // UserDefaultからURLを取得
        let URLstr: String = UserDefaults.standard.string(forKey: "URL") ?? ""
        // URL複合化
        self.URLstr = Cryption.ddd(base64: URLstr)
        print(self.URLstr)
        do {
            // Audiosessionの設定
            try setAudiosession()
        } catch {
            print(error)
            return
        }
        
        // playerのセットアップ
        setupPlayer()
    }
    
    @IBAction func tapPlayPauseButton(_ sender: Any) {
        if !isPlaying() {
            player.play()
            playPauseButton.setImage(UIImage(systemName:"pause.fill"), for: .normal)
        } else {
            player.pause()
            playPauseButton.setImage(UIImage(systemName:"play.fill"), for: .normal)
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let seconds = Double(sender.value) * itemDuration
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: seconds, preferredTimescale: timeScale)
        
        changePosition(time: time)
    }
    
    @IBAction func tapExitFullScreenButton(_ sender: Any) {
        
    }
    
    // Audio sessionの設定
    func setAudiosession() throws {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .moviePlayback)
            
        } catch {
            throw error
        }
        do {
            try audioSession.setActive(true)
            print("Audio session set active")
        } catch {
            print("Audio session unset active")
            throw error
        }
    }
    
    func setVideoPlayer(_ player: AVPlayer) {
        self.player = player
    }
    
    // playerのセットアップ
    func setupPlayer () {
        
        // 動画ファイルの長さを示す秒数を設定する
        let asset = AVAsset(url: URL(string: self.URLstr)!)
        itemDuration = CMTimeGetSeconds(asset.duration)
        
        let playItem = AVPlayerItem(url: URL(string: self.URLstr)!)
        playerView.player = player
        player.seek(to: self.time)
        addPeriodicTimeObserver()
        
        // 動画再生の終了を検知するように設定
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: playItem)
    }
    
    // 再生中:true 停止中:false
    func isPlaying() -> Bool {
        if player.timeControlStatus == .playing {
            return true
        } else {
            return false
        }
    }
    
    // 再生に合わせてシークバーを動かす
    func addPeriodicTimeObserver() {
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: time,
                                                           queue: .main)
        { [weak self] time in
            // update player transport UI
            DispatchQueue.main.async {
                // sliderを更新
                self?.updateSlider()
            }
        }
    }
    
    private func updateSlider() {
        let time = player.currentItem?.currentTime() ?? CMTime.zero
        if itemDuration != 0 {
            videoTimeSlider.value = Float(CMTimeGetSeconds(time) / itemDuration)
        }
    }
    
    private func changePosition(time: CMTime) {
        let rate = player.rate
        // いったんplayerをとめる
        player.rate = 0
        // 指定した時間へ移動
        player.seek(to: time, completionHandler: {_ in
            // playerをもとのrateに戻す(0より大きいならrateの速度で再生される)
            self.player.rate = rate
        })
    }
    
    @objc func playerDidFinishPlaying() {
    print("MovieFinish!!")
        player.seek(to: CMTimeMakeWithSeconds(0, preferredTimescale: 1))
    }
    
}
