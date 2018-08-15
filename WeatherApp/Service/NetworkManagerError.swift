//
//  NetworkManagerError.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 15.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

enum NetworkManagerError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case responseUnsuccessfulCode404
    case responseUnsuccessfulCode401
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        case .responseUnsuccessfulCode404: return "City not found"
        case .responseUnsuccessfulCode401:
            return "Invalid API key. Please see http://openweathermap.org/faq#error401 for more info"
        }
    }
}
