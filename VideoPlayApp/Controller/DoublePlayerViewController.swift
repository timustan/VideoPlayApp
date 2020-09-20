//
//  DoublePlayerViewController.swift
//  VideoPlayApp
//
//  Created by teramoto on 2020/09/14.
//  Copyright © 2020 natsumi. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit

class DoublePlayerViewController: UIViewController {
    @IBOutlet weak var upperPlayerView: PlayerView!
    @IBOutlet weak var underPlayerView: PlayerView!
  
    var player = AVPlayer()
    var URL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 動画URLを取得
        URL = getURL()
        do {
            // Audiosessionの設定
            try setAudiosession()
        } catch {
            print(error)
            return
        }

    }
    
    func getURL() -> String {
        let URLstr: String = UserDefaults.standard.string(forKey: "URL") ?? ""
        let CryptURL = Cryption.ddd(base64: URLstr)
        print("playing video URL = \(CryptURL)")
        return CryptURL
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
    func setupPlayer() {
        let playItem = AVPlayerItem(url: URL(String: self.URL))
        let upperPlayerLayer = AVPlayer(playerItem: playItem)
        upperPlayerView.player = upperPlayerLayer
        let underPlayerLayer = AVPlayer(playerItem: playItem)
        underPlayerView.player = underPlayerLayer
        
        upperPlayerLayer.play()
        underPlayerLayer.play()
        
    }


}
