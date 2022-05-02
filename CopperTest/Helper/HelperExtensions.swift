//
//  HelperExtensions.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }
}

extension UIColor {
    convenience init(hex: Int) {
        let red = CGFloat((hex & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00ff00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000ff) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
