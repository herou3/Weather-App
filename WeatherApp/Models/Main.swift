//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation
struct Main: Codable {
	let temp: Double?
	let pressure: Int?
	let humidity: Int?
	let tempMin: Double?
	let tempMax: Double?

	enum CodingKeys: String, CodingKey {

		case temp = "temp"
		case pressure = "pressure"
		case humidity = "humidity"
		case tempMin = "temp_min"
		case tempMax = "temp_max"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		temp = try values.decodeIfPresent(Double.self, forKey: .temp)
		pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
		humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
		tempMin = try values.decodeIfPresent(Double.self, forKey: .tempMin)
		tempMax = try values.decodeIfPresent(Double.self, forKey: .tempMax)
	}

}
