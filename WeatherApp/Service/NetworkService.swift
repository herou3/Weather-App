//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 08.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON

class NetworkService {
    // MARK: - Propery
    let tron = TRON(baseURL: Constant.baseUrl)
    var weatherObj = WeatherByCity()
    
    // MARK: - Action
    func featchHomeFeed(city: String) {
        _ = URLSession.shared
        _ = URL(string: "\(Constant.baseUrl)?APPID=\(Constant.appId)&q=\(city)")
        let request: APIRequest<WeatherResponse, MyError> = tron.req
        request.method = .post
        request.parameters = ["APPID": "\(Constant.appId)", "q": "\(city)"]
        request.perform(withSuccess: { (weatherResponse) in
            self.weatherObj = weatherResponse.weatherByCity
        }) { (error) in
            print(error.response?.statusCode ?? "Status Code Missing")
            guard let err = error.errorModel else { return }
            print(err.isEmpty)
        }
        }
        
//        let session = URLSession.shared
//        let weatherRequestURL = URL(string: "\(Constant.baseUrl)?APPID=\(Constant.appId)&q=\(city)")
//        let dataTask = session.dataTask(with: weatherRequestURL!) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
//
//            guard let data = data else { return }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//        } catch {
//                print(error)
//            }
//            }.resume()
//        }
}
    
class JSONError: JSONDecodable {
    required init(json: JSON) throws {
        print("JSON Error")
    }
}
