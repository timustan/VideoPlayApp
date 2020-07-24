//
//  Cryption.swift
//  VideoPlayApp
//
//  Created by teramoto on 2020/07/24.
//  Copyright © 2020 natsumi. All rights reserved.
//

import Foundation
import CryptoSwift

/* 暗号化・復号化 */
class Cryption {
    private static let kkk = Bundle.main.bundleIdentifier!.sha256()[0 ... 31]
    private static let initialVector = Bundle.main.bundleIdentifier!.sha256()[48 ... 63]

    /// 暗号化処理
    static func eee(text: String) -> String {
        do {
            // 暗号化処理
            // AES インスタンス化
            let aes = try AES(key: Const.cryptKey, iv: Const.cryptIv)
            let encrypt = try aes.encrypt(Array(text.utf8))

            // Data 型変換
            let data = Data(encrypt)
            // base64 変換
            let base64Data = data.base64EncodedData()
            // UTF-8変換 nil 不可
            guard let base64String =
                String(data: base64Data as Data, encoding: String.Encoding.utf8)
            else { return "" }

            // base64文字列
            return base64String

        } catch {
            // エラー処理
            return ""
        }
    }

    /// 複合処理
    static func ddd(base64: String) -> String {
        do {
            // AES インスタンス化
            let aes = try AES(key: Const.cryptKey, iv: Const.cryptIv)

            // base64 から Data型へ
            let byteData = base64.data(using: String.Encoding.utf8)! as Data
            // base64 デーコード
            guard let data = Data(base64Encoded: byteData)
            else { return "" }

            // UInt8 配列の作成
            let aBuffer = [UInt8](data)
            // AES 複合
            let decrypted = try aes.decrypt(aBuffer)
            // UTF-8変換
            guard let text = String(data: Data(decrypted), encoding: .utf8)
            else { return "" }

            return text
        } catch {
            // エラー処理
            return ""
        }
    }
}

