//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

struct WeatherByCity: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dat: Int?
    let sys: Sys?
    let identifier: Int?
    let name: String?
    var code: Int?
    
    enum CodingKeys: String, CodingKey {
        
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dat = "dt"
        case sys
        case identifier = "id"
        case name
        case code = "cod"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        coord = try values.decodeIfPresent(Coord.self, forKey: .coord)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        base = try values.decodeIfPresent(String.self, forKey: .base)
        main = try values.decodeIfPresent(Main.self, forKey: .main)
        visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
        wind = try values.decodeIfPresent(Wind.self, forKey: .wind)
        clouds = try values.decodeIfPresent(Clouds.self, forKey: .clouds)
        dat = try values.decodeIfPresent(Int.self, forKey: .dat)
        sys = try values.decodeIfPresent(Sys.self, forKey: .sys)
        identifier = try values.decodeIfPresent(Int.self, forKey: .identifier)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        code =  try values.decode(Int.self, forKey: .code)
    }
}
