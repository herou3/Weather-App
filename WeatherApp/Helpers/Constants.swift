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
    static let marginLeftAndRightValue: CGFloat = 16.0
    static let briefInformationHightValue: CGFloat = 132
    static let baseUrl: String = "http://api.openweathermap.org/"
    static let coordinatesOfParis = CLLocationCoordinate2D(latitude: 48.85341, longitude: 2.3488)
    static let kelvinTemperatureZero: Double = 273.15
    static let latitudeDeltaValue: CLLocationDegrees = 0.017
    static let longitudeDeltaValue: CLLocationDegrees = 0.017
}
