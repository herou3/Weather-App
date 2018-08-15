//
//  NetworkRequests.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 15.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

class NetworkRequests: NetworkManager {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    //in the signature of the function in the success case we define the Class type thats is the generic one in the API
    func getFeed(from movieFeedType: WeatherFeed,
                 use cityName: String,
                 completion: @escaping (Result<WeatherByCity?, NetworkManagerError>) -> Void) {
        let localRequest =  movieFeedType.requestCiry(at: cityName)
        fetch(with: localRequest, decode: { json -> WeatherByCity? in
            guard let movieFeedResult = json as? WeatherByCity else { return  nil }
            return movieFeedResult
        }, completion: completion)
    }
}
