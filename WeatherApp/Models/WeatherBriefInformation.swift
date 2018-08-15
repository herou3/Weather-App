//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

struct WeatherBriefInformation: Codable {
	let id: Int?
	let main: String?
	let description: String?
	let icon: String?

	enum CodingKeys: String, CodingKey {

		case id
		case main
		case description
		case icon
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		main = try values.decodeIfPresent(String.self, forKey: .main)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
	}

}
