//
//  NetworkEndpoint.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 15.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

protocol NetworkEndpoint {
    var base: String { get }
    var path: String { get }
}

extension NetworkEndpoint {
    var apiKey: String {
        return "aa70143c41d12726b8a9a997c911f2c0"
    }
    
    func requestCiry(at city: String) -> URLRequest {
        let queryItemKey = URLQueryItem(name: "APPID", value: apiKey)
        let queryItemKCity = URLQueryItem(name: "q", value: city)
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = [queryItemKCity, queryItemKey]
        guard let url = components.url else { return URLRequest(url: URL(string: Constant.baseUrl)!) }
        return URLRequest(url: url)
    }
}
