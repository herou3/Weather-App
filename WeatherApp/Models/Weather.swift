//
//  Weather.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

private struct Keys {
    static let id: String = "id"
    static let main: String = "main"
    static let description: String = "description"
    static let icon: String = "icon"
}

struct Weather {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
    
    init(json: JSON) {
        self.id = json[Keys.id].intValue
        self.main = json[Keys.main].stringValue
        self.description = json[Keys.description].stringValue
        self.icon = json[Keys.icon].stringValue
    }
    
    init() { }
}
