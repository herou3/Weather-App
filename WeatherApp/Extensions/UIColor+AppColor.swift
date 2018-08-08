//
//  UIColor+AppColor.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 02.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

// MARK: - Common
extension UIColor {
    static func color(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    // MARK: - AppColors
    class var cardinal: UIColor {
        return color(196, 30, 58)
    }
    
    class var carmine: UIColor {
        return color(150, 0, 24)
    }
    
    class var mainColor: UIColor {
        return color(253, 234, 207)
    }
}
