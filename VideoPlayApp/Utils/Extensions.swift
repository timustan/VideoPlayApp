//
//  Extensions.swift
//  VideoPlayApp
//
//  Created by teramoto on 2020/07/24.
//  Copyright © 2020 natsumi. All rights reserved.
//

import Foundation
import UIKit

// n番目の文字を取得するExtension
extension String {
    subscript(bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start ... end])
    }
}

// sliderのイメージを設定する
extension UIImage {
    class func circle(diameter: CGFloat, color: UIColor!) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: diameter, height: diameter), false, 0)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        let rect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        ctx.setFillColor(color.cgColor)
        ctx.fillEllipse(in: rect)
        ctx.restoreGState()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
