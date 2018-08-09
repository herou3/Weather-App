//
//  ErrorResponse.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

import Foundation
struct ErrorResponse: Codable {
    let cod: Int?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        
        case cod
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cod = try values.decodeIfPresent(Int.self, forKey: .cod)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
    
}
