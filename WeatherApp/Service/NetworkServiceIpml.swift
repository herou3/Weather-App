//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation
import KRProgressHUD

public enum NetworkServiceError: Error {
        case failed
}

class NetworkServiceImpl: NetworkService {
    
    // MARK: - Action
    func featchHomeFeed(at url: URL, completion: @escaping (WeatherByCity?, ErrorResponse?) -> Void) {
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            if let response = response {
                print(response)
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                let jsonDecoder = JSONDecoder()
                if (response as? HTTPURLResponse)?.statusCode == 200 {
                    let responseModel = try jsonDecoder.decode(WeatherByCity.self, from: data)
                    completion(responseModel, nil)
                } else {
                    let errorCode = try jsonDecoder.decode(ErrorResponse.self, from: data)
                    completion(nil, errorCode)
                }
            } catch {
                print(error)
            }
            }.resume()
    }
}
//
//extension NetworkServiceImpl {
//    static func
//}
