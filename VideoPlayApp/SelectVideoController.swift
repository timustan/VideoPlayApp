//
//  SelectVideoController.swift
//  VideoPlayApp
//
//  Created by natsumi on 2020/04/10.
//  Copyright © 2020 natsumi. All rights reserved.
//

import UIKit
import CoreServices
import Photos

class SelectVideoController: UIViewController, UIImagePickerControllerDelegate ,UINavigationControllerDelegate {
    
    
    @IBOutlet weak var SelectVideoButton: UIButton!
    @IBOutlet weak var InputURLButton: UIButton!
    @IBOutlet weak var InputURLField: UITextField!
    @IBOutlet weak var DecisionButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()
        registerPhotoLibrary()
        
        
        // Do any additional setup after loading the view.
    }
    
    // 権限を求める
    func registerPhotoLibrary() {
        // アクセス権限に対して明確な回答がない場合
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { _ in
            }
        }
    }
    
    let imagePickerController = UIImagePickerController()
    // ライブラリから動画を選択する
    @IBAction func SelectVideoButton(_ sender :Any){
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        present(imagePickerController, animated: true,completion: nil)
    }
    
    
    // レイアウトを設定する
    func setButtons(){
        // 「動画を選択する」ボタンの配置を設定
        SelectVideoButton.frame = CGRect(x:(self.view.frame.size.width / 2) - 107, y: self.view.frame.size.height * 3 / 12, width: 214, height: 65)
        SelectVideoButton.autoresizingMask = [.flexibleWidth,.flexibleHeight,.flexibleTopMargin]
        // 枠の設定
        SelectVideoButton.layer.borderColor = UIColor.white.cgColor
        SelectVideoButton.layer.borderWidth = 3
        SelectVideoButton.layer.cornerRadius = 10
        
        // 「URLを入力する」ボタンの配置を設定
        InputURLButton.frame = CGRect(x:(self.view.frame.size.width / 2) - 107, y: self.view.frame.size.height * 5 / 12, width: 214, height: 65)
        InputURLButton.autoresizingMask = [.flexibleWidth,.flexibleHeight,.flexibleTopMargin]
        // 枠の設定
        InputURLButton.layer.borderColor = UIColor.white.cgColor
        InputURLButton.layer.borderWidth = 3
        InputURLButton.layer.cornerRadius = 10
        
        // URL入力フィールドの配置を設定
        
        
        // 決定ボタンの配置を設定
        
        
    }
    
    
}

