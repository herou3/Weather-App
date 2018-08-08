//
//  Wind.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

private struct Keys {
    static let speed: String = "speed"
    static let deg: String = "deg"
}

struct Wind {
    var speed: CGFloat?
    var deg: Int?
    
    init(json: JSON) {
        self.speed = CGFloat(json[Keys.speed].floatValue)
        self.deg = json[Keys.deg].intValue
    }
    
    init() { }
}
