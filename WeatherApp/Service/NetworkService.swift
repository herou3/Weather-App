//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 10.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

protocol NetworkService {
   func featchHomeFeed(at url: URL, completion: @escaping (WeatherByCity?, ErrorResponse?) -> Void)
}
