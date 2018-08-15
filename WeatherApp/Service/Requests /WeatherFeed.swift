//
//  WeatherFeed.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 15.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

import Foundation

enum WeatherFeed {
    case city
}

extension WeatherFeed: NetworkEndpoint {
    
    var base: String {
        return Constant.baseUrl
    }
    
    var path: String {
        switch self {
        case .city: return "/data/2.5/weather"
        }
    }
}
