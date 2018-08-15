//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

struct WeatherMainInformation: Codable {
	let temp: Double?
	let pressure: Double?
	let humidity: Int?
	let tempMin: Double?
	let tempMax: Double?
    let seaLevel: Double?
    let grndLevel: Double?

	enum CodingKeys: String, CodingKey {

		case temp
		case pressure
		case humidity
		case tempMin = "temp_min"
		case tempMax = "temp_max"
        case seaLevel = "sea_Level"
        case grndLevel = "grnd_Level"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		temp = try values.decodeIfPresent(Double.self, forKey: .temp)
		pressure = try values.decodeIfPresent(Double.self, forKey: .pressure)
		humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
		tempMin = try values.decodeIfPresent(Double.self, forKey: .tempMin)
		tempMax = try values.decodeIfPresent(Double.self, forKey: .tempMax)
        seaLevel = try values.decodeIfPresent(Double.self, forKey: .seaLevel)
        grndLevel = try values.decodeIfPresent(Double.self, forKey: .grndLevel)
	}
}
