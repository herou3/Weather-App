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
        KRProgressHUD.show()
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(WeatherByCity.self, from: data)
                if responseModel.code != 200 {
                    let responseModel = try jsonDecoder.decode(ErrorResponse.self, from: data)
                    completion(nil, responseModel)
                } else {
                    print(responseModel)
                    completion(responseModel, nil)
                }
            } catch {
                print(error)
            }
            }.resume()
    }
}
