//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

struct WeatherByCity: Codable {
    let coordinate: Coordinate?
    let weatherBriefInformation: [WeatherBriefInformation]?
    let base: String?
    let weatherMainInformation: WeatherMainInformation?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let date: Int?
    let cityInformation: CityInformation?
    let identifier: Int?
    let name: String?
    var code: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case coordinate = "coord"
        case weatherBriefInformation = "weather"
        case base
        case weatherMainInformation = "main"
        case visibility
        case wind
        case clouds
        case date = "dt"
        case cityInformation = "sys"
        case identifier = "id"
        case name
        case code = "cod"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coordinate = try values.decodeIfPresent(Coordinate.self, forKey: .coordinate)
        weatherBriefInformation = try values.decodeIfPresent([WeatherBriefInformation].self, forKey: .weatherBriefInformation)
        base = try values.decodeIfPresent(String.self, forKey: .base)
        weatherMainInformation = try values.decodeIfPresent(WeatherMainInformation.self, forKey: .weatherMainInformation)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        date = try values.decodeIfPresent(Int.self, forKey: .date)
        cityInformation = try values.decodeIfPresent(CityInformation.self, forKey: .cityInformation)
        identifier = try values.decodeIfPresent(Int.self, forKey: .identifier)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        code =  try values.decode(Int.self, forKey: .code)
    }
}
