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
    
    var player = AVPlayer()
    var videoURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(videoURL ?? "うまくいってないよ〜")

    }
    @IBAction func tapPlayPauseButton(_ sender: Any) {
    }
    
}
