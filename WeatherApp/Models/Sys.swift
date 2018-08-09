//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation
struct Sys: Codable {
	let type: Int?
	let identifier: Int?
	let message: Double?
	let country: String?
	let sunrise: Int?
	let sunset: Int?

	enum CodingKeys: String, CodingKey {

		case type
		case identifier = "id"
		case message
		case country
		case sunrise
		case sunset
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(Int.self, forKey: .type)
		identifier = try values.decodeIfPresent(Int.self, forKey: .identifier)
		message = try values.decodeIfPresent(Double.self, forKey: .message)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
		sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
	}

}
