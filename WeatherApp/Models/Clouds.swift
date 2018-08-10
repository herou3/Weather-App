//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

struct Clouds: Codable {
	let all: Int?

	enum CodingKeys: String, CodingKey {
		case all
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		all = try values.decodeIfPresent(Int.self, forKey: .all)
	}

}
