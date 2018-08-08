//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import LBTAComponents
import SwiftyJSON
import TRON

struct WeatherResponse: JSONDecodable {
    // MARK: - Property
    let weatherByCity: WeatherByCity
    
    init(json: JSON) throws {
        print(json)
        guard let weather  = json.object as? WeatherByCity else {
            throw NSError(domain: "ru.test.space-o",
                          code: 1,
                          userInfo: [NSLocalizedDescriptionKey: "Parsing JSON is not valid"])
        }
        self.weatherByCity = weather
    }
}
