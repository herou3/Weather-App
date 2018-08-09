//
//  NetworkServiceImpl.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

class NetworkServiceImpl: NetworkService {
    
    func data(at url: URL, completion: @escaping (Data?, Error?) -> Void) {
        _ = self.session.dataTask(with: url) { data, response, error in
            print(response ?? "Test")
            switch (data, error) {
            case (nil, nil): completion(nil, NetworkServiceError.failed)
            default: completion(data, error)
            }
        }
//        return NetworkTask(urlSessionTask: dataTask)
    }
    
    // MARK: - Properties
    private var session = URLSession(configuration: .default)
    
    // MARK: - Init
    public init(session: URLSession) {
        self.session = session
    }
}

import TRON
import SwiftyJSON

class NetworkServiceFLE {
    // MARK: - Propery
    let tron = TRON(baseURL: Constant.baseUrl)
    
    // MARK: - Action
//    func featchHomeFeed(completion: @escaping (WeatherByCity?, Error?) -> Void) {
////        let request: APIRequest<RecipesResponse, JSONError> = tron.swiftyJSON.request("recipes")
//        let request: APIRequest<WeatherByCity, JSONError> = tron.swiftyJSON.request("fdsf")
//        request.perform(withSuccess: { (recipeDataSource) in
//            completion(recipeDataSource, nil)
//        }) { (err) in
//            completion(nil, err)
//        }
//    }
//    
//    class JSONError: JSONDecodable {
//        required init(json: JSON) throws {
//            print("JSON Error")
//        }
//    }
//}
//
//struct RecipesResponse: JSONDecodable {
//    // MARK: - Property
//    let weatherByCity: WeatherByCity
//    
//    init(json: JSON) throws {
//        print(json)
//        let jsonDecoder = JSONDecoder()
//        let responseModel = try jsonDecoder.dec
//        self.weatherObj = responseModel
//        if responseModel.cod == 200 {
//            print("Fack off")
//        }
//    }
}

