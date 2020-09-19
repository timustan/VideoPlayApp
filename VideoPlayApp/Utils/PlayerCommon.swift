//
//  PlayerCommon.swift
//  VideoPlayApp
//
//  Created by teramoto on 2020/09/05.
//  Copyright © 2020 natsumi. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import AVKit

class PlayerCommon: UIViewController {
    
    var player = AVPlayer()
    var itemDuration: Double = 0
    var timeObserverToken: Any?
    var timeSlider: UISlider!
    
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
            timeSlider.value = Float(CMTimeGetSeconds(time) / itemDuration)
        }
    }
    
    // 再生中:true 停止中:false
    func isPlaying() -> Bool {
        if player.timeControlStatus == .playing {
            return true
        } else {
            return false
        }
    }
    
    @objc func playerDidFinishPlaying() {
        player.seek(to: CMTimeMakeWithSeconds(0, preferredTimescale: 1))
    }
}
