//
//  MyError.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

struct MyError: JSONDecodable {
    
    let isEmpty: Bool
    
    init(json: JSON) throws {
        print("JSON: \(json)")
        print("JSON parsing error")
        isEmpty = json.isEmpty
    }
    
}
