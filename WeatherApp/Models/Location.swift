//
//  Location.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

struct Location {
    var city: String?
    var lat: CGFloat?
    var lon: CGFloat?
    
    init() { }
    
    init(city: String?, lat: CGFloat?, lon: CGFloat?) {
        self.city = city
        self.lat = lat
        self.lon = lon
    }
}
