//
//  AppDelegate.swift
//  VideoPlayApp
//
//  Created by natsumi on 2020/04/10.
//  Copyright © 2020 natsumi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // iOS13以降はSceneDelegateで設定を行う
        if #available(iOS 13.0, *) {
        } else {
            // ナビゲーションバーの色を変更する
            UINavigationBar.appearance().barTintColor = UIColor.black
            // ナビゲーションバーのタイトルの文字色を変更する
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.lightGray]
        }
        return true
    }
}

