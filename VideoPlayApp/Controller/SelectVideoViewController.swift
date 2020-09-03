//
//  SelectVideoViewController.swift
//  VideoPlayApp
//
//  Created by teramoto on 2020/07/10.
//  Copyright © 2020 natsumi. All rights reserved.
//

import UIKit
import Photos
import CoreServices
import CryptoSwift
import os.log

class SelectVideoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    // 入力バー
    @IBOutlet var inputBarView: UIView!
    // URL入力TextField
    @IBOutlet var inputURLTextField: UITextField!
    
    @IBOutlet var inputBarViewYCoordinate: NSLayoutConstraint!
    
    // 動画再生画面遷移用identifier
    let identifier = "PlayVideoViewController"
    // UIImagePickerController
    let imagePickerController = UIImagePickerController()
    // log
    let log = OSLog(subsystem: "com.timustan.VideoPlayApp", category: "SelectVideoView")
    // URL
    var videoURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 権限を求める
        askForAuthority()
        inputURLTextField.delegate = self
        //　キーボードの開閉を検知する
        NotificationCenter.default.addObserver(
          self,
          selector:#selector(keyboardWillShow(_:)),
          name: UIResponder.keyboardWillShowNotification,
          object: nil
        )
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(keyboardWillHide(_:)),
          name: UIResponder.keyboardWillHideNotification,
          object: nil
        )
    }
    
    // 「動画を選択する」ボタン押下時
    @IBAction func clickedSelectVideoButton(_ sender: Any) {
        // 権限の確認　拒否状態の場合return
        if !checkAuthority() {
            return
        } else {
            // UIImagePickerを表示
            showImagePicker()
        }
        
    }
    // 「URLを入力する」ボタン押下時
    @IBAction func tapInputURLButton(_ sender: Any) {
        inputURLTextField.becomeFirstResponder()
    }
    
    // 「決定」ボタン押下時
    @IBAction func tapDecisionButton(_ sender: Any) {
        self.videoURL = URL(string: self.inputURLTextField.text!)
        // 動画再生画面に遷移
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
    
    // 権限を求める
    func askForAuthority() {
        // ライブラリへのアクセス許可がない場合
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            // 権限を要求する
            PHPhotoLibrary.requestAuthorization { status in
                if status != .authorized {
                    os_log(.default, log: self.log, "ライブラリへのアクセス拒否")
                    
                    return
                }
                os_log(.default, log: self.log, "ライブラリへのアクセス許可")
            }
        }
    }
    
    // 権限の確認
    func checkAuthority() -> Bool {
        // アクセス拒否状態の場合
        if PHPhotoLibrary.authorizationStatus() != .authorized {
            self.showAlert(title: Const.AUTHORITY_ALERT_TITLE, message: Const.AUTHORITY_ALERT_MESSAGE)
            return false
        }
        return true
    }
    
    // UIImagePickerControllerの表示
    func showImagePicker() {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeMovie as String]
        present(imagePickerController, animated: true)
    }
    
    // 動画選択後に呼ばれる
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info[.mediaURL] ?? "")
        // URL -> String
        let URLstr = (info[.mediaURL] as! URL).absoluteString
        // 取得したURLを暗号化
        let videoURL = Cryption.eee(text: URLstr)
        // UserDefaultにURLを保存
        UserDefaults.standard.set(videoURL, forKey: "URL")
        // 動画再生画面に遷移
        self.performSegue(withIdentifier: identifier, sender: nil)
        dismiss(animated: true)
    }
    
    // 動画選択キャンセル時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    // キーボードが開いたら、高さを取得しテキストフィールドを表示する
    @objc func keyboardWillShow(_ notification: Notification) {
      guard let userInfo = notification.userInfo as? [String: Any] else {
        return
      }
      guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
        return
      }
      //キーボードの高さを取得
      guard let rect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
        return
      }
      UIView.animate(withDuration: duration , delay: 0.5, animations: {
        // キーボードの上にTextFieledが来るようにする
        self.inputBarViewYCoordinate.constant = rect.height
        self.inputBarView.isHidden = false
      })
    }
    
    // キーボードが閉じたらテキストフィールドを隠す
    @objc private func keyboardWillHide(_ notification: Notification) {
        //キーボードが閉じたときの処理
        inputBarView.isHidden = true
    }
    
    // アラートを表示する
    func showAlert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAct: UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: { (_: UIAlertAction!) -> Void in
        })
        alert.addAction(cancelAct)
        present(alert, animated: true)
    }
    
    // textField以外をタッチしたらキーボードを閉じる
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }
    
    // キーボードの完了ボタン押下でキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputURLTextField.resignFirstResponder()
        return true
    }
}
