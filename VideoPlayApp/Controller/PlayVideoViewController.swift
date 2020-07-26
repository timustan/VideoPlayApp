//
//  PlayVideoViewController.swift
//  VideoPlayApp
//
//  Created by teramoto on 2020/07/11.
//  Copyright © 2020 natsumi. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit

class PlayVideoViewController: UIViewController {

    @IBOutlet var playerView: PlayerView!
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet weak var videoTimeSlider: UISlider!
    
    var player = AVPlayer()
    var URLstr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UserDefaultからURLを取得
        let URLstr: String = UserDefaults.standard.string(forKey: "URL") ?? ""
        print(URLstr)
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
    
    // 再生/停止ボタン押下時
    @IBAction func tapPlayPauseButton(_ sender: Any) {
        player.play()
        
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
    
    // playerのセットアップ
    func setupPlayer () {
        let playItem = AVPlayerItem(url: URL(string: self.URLstr)!)
        player = AVPlayer(playerItem: playItem)
        playerView.player = player
    }
}
