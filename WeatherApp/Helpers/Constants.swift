//
//  Constants.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 02.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation
import UIKit
import MapKit

struct Constant {
    static var appName: String? {
        return Bundle.main.infoDictionary!["CFBundleName"] as? String
    }
    static let marginLeftAndRight: CGFloat = 32.0
    static let baseUrl: String = "http://api.openweathermap.org/data/2.5/weather"
    static let appId: String = "aa70143c41d12726b8a9a997c911f2c0"
    static let cellHeight: CGFloat = 310
    static let maxImagesCount: Int = 10
    static let coordinatesOfParis = CLLocationCoordinate2D(latitude: 48.85341, longitude: 2.3488)
    static let kelvinTemperatureZero: Double = 273.15
}
