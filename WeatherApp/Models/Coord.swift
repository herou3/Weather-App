//
//  Coord.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

private struct Keys {
    static let lon: String = "lon"
    static let lat: String = "lat"
}

struct Coord {
    var lat: CGFloat?
    var lon: CGFloat?
    
    init(json: JSON) {
        self.lat = CGFloat(json[Keys.lat].floatValue)
        self.lon = CGFloat(json[Keys.lon].floatValue)
    }
    
    init() { }
}
