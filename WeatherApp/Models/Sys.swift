//
//  Sys.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

private struct Keys {
    static let type: String = "type"
    static let id: String = "id"
    static let message: String = "message"
    static let country: String = "country"
    static let sunrise: String = "sunrise"
    static let sunset: String = "sunset"
}

struct Sys {
    var type: Int?
    var id: Int?
    var message: String?
    var country: String?
    var sunrise: String?
    var sunset: String?
    
    init(json: JSON) {
        self.type = json[Keys.type].intValue
        self.id = json[Keys.id].intValue
        self.message = json[Keys.message].stringValue
        self.country = json[Keys.country].stringValue
        self.sunrise = json[Keys.sunrise].stringValue
        self.sunset = json[Keys.sunset].stringValue
    }
    
    init() { }
}
