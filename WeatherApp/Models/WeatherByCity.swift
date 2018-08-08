//
//  WeatherByCity.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit
import TRON
import SwiftyJSON

private struct Keys {
    static let coord: String = "coord"
    static let weather: String = "weather"
    static let base: String = "base"
    static let main: String = "main"
    static let visibility: String = "visibility"
    static let wind: String = "wind"
    static let clouds: String = "clouds"
    static let dat: String = "dt"
    static let sys: String = "sys"
    static let id: String = "id"
    static let name: String = "name"
    static let cod: String = "cod"
}

struct WeatherByCity {
    var coord: Coord?
    var weather: Weather?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dat: String?
    var sys: Sys?
    var id: Int?
    var name: String?
    var cod: Int?
    
    init(json: JSON) {
        self.coord = json[Keys.coord].object as? Coord
        self.weather = json[Keys.weather].object as? Weather
        self.base = json[Keys.base].stringValue
        self.main = json[Keys.main].object as? Main
        self.visibility = json[Keys.main].intValue
        self.wind = json[Keys.wind].object as? Wind
        self.clouds = json[Keys.clouds].object as? Clouds
        self.dat = json[Keys.dat].stringValue
        self.sys = json[Keys.sys].object as? Sys
        self.id = json[Keys.id].intValue
        self.name = json[Keys.name].stringValue
        self.cod = json[Keys.cod].intValue
    }
    
    init() { }
}
