//
//  Clouds.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

private struct Keys {
    static let all: String = "all"
}

struct Clouds {
    var all: Int?
    
    init(json: JSON) {
        self.all = json[Keys.all].intValue
    }
    
    init() { }
}
