//
//  ErrorResponse.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    let code: Int?
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        
        case code = "cod"
        case message
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let code =  try? values.decode(Int.self, forKey: .code) {
            self.code = code
        } else if let code = try? values.decode(String.self, forKey: .code) {
            self.code = Int(code)
        } else {
            code = nil
        }
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}
