//
//  Main.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

private struct Keys {
    static let temp: String = "temp"
    static let pressure: String = "pressure"
    static let humidity: String = "humidity"
    static let tempMin: String = "temp_min"
    static let tempMax: String = "temp_max"
}

struct Main {
    var temp: Int?
    var pressure: Int?
    var humidity: Int?
    var tempMin: String?
    var tempMax: String?
    
    init(json: JSON) {
        self.temp = json[Keys.temp].intValue
        self.pressure = json[Keys.pressure].intValue
        self.humidity = json[Keys.humidity].intValue
        self.tempMin = json[Keys.tempMin].stringValue
        self.tempMax = json[Keys.tempMax].stringValue
    }
    
    init() { }
}
