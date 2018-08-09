//
//  WeatherDownloadServiceImpl.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

class WeatherDownloadServiceImpl: WeatherDownloadService {
    
    // MARK: - Properties
    public let networkService: NetworkService
    private var session = URLSession(configuration: .default)
    
    public init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func data(at url: URL, completion: @escaping (WeatherByCity?) -> Void) {
        self.networkService.data(at: url) { (data, error) in
            if error != nil {
                completion(nil)
            } else {
                completion(data.flatMap({ (data) -> WeatherByCity? in
                    do {
                        let jsonDecode = JSONDecoder()
                        let weatherObj =  try jsonDecode.decode(WeatherByCity.self, from: data)
                        return weatherObj
                    } catch {
                        return nil
                    }
                })
            )}
        }
    }
}
