//
//  SceneDelegate.swift
//  VideoPlayApp
//
//  Created by natsumi on 2020/04/10.
//  Copyright © 2020 natsumi. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // ナビゲーションバーの色を変更する
        UINavigationBar.appearance().barTintColor = UIColor.black
        // ナビゲーションバーのタイトルの文字色を変更する
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.lightGray]
    }
}

