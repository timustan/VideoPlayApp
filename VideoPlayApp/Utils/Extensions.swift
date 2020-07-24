//
//  Extensions.swift
//  VideoPlayApp
//
//  Created by teramoto on 2020/07/24.
//  Copyright © 2020 natsumi. All rights reserved.
//

import Foundation

// n番目の文字を取得するExtension
extension String {
    subscript(bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start ... end])
    }
}
