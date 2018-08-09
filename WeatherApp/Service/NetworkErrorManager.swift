//
//  NetworkErrorManager.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

class NetworkErrorManager: NSObject {
    
    static let networkErrorDomain = "DoctorNetworkError"
    
    enum StatusCode: Int {
        case okStatus = 200
        case badRequest = 400
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case internalError = 500
    }
    
    class func error(from errorResponse: ErrorResponse) -> Error {
        let message = errorResponse.message ?? "Unknown server error."
        let userInfo = [NSLocalizedDescriptionKey: message]
        return NSError(domain: networkErrorDomain, code: errorResponse.cod!, userInfo: userInfo) as Error
    }
    
    class func unknownError() -> Error {
        let userInfo = [NSLocalizedDescriptionKey: "Unknown server error."]
        return NSError(domain: networkErrorDomain, code: 0, userInfo: userInfo) as Error
    }
    
    class func parseError() -> Error {
        let userInfo = [NSLocalizedDescriptionKey: "Unexpected server response format."]
        return NSError(domain: networkErrorDomain, code: 0, userInfo: userInfo) as Error
    }
}
