//
//  SelectVideoViewController.swift
//  VideoPlayApp
//
//  Created by teramoto on 2020/07/10.
//  Copyright © 2020 natsumi. All rights reserved.
//

import UIKit

class SelectVideoViewController: UIViewController, UITextFieldDelegate {
    
    // 入力バー
    @IBOutlet var inputBarView: UIView!
    // URL入力TextField
    @IBOutlet var inputURLTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputURLTextField.delegate = self
    }
    
    // 「動画を選択する」ボタン押下時
    @IBAction func clickedSelectVideoButton(_ sender: Any) {
    }
    
    // 「URLを入力する」ボタン押下時
    @IBAction func clickedInputURLButton(_ sender: Any) {
        inputURLTextField.becomeFirstResponder()
    }
    
    // 「決定」ボタン押下時
    @IBAction func clickedDecisionButton(_ sender: Any) {
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
