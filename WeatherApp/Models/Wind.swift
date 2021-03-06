//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

struct Wind: Codable {
	let speed: Double?
	let degrees: Double?

	enum CodingKeys: String, CodingKey {

		case speed
		case degrees = "deg"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		speed = try values.decodeIfPresent(Double.self, forKey: .speed)
		degrees = try values.decodeIfPresent(Double.self, forKey: .degrees)
	}
}
