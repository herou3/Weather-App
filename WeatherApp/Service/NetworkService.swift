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

class NetworkServiceFL {
    // MARK: - Propery
//    var weatherObj: WeatherByCity?
//
    // MARK: - Action
func featchHomeFeed(at url: URL, completion: (Data, Error) -> Void) {
        KRProgressHUD.show()
        let session = URLSession.shared
//        let weatherRequestURL = URL(string: "\(Constant.baseUrl)?APPIDs=\(Constant.appId)&q=\(city)")
        session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error ?? "Error")
                KRProgressHUD.showError()
                return
            }
            if let response = response {
                print(response)
            }
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(WeatherByCity.self, from: data)
        } catch {
            print(error)
            KRProgressHUD.showError()
            }
        }.resume()
    }
    
    func asyncExample2(with completion: @escaping (() -> Void)) {
        //The same as the above method - the compiler sees the `@escaping` nature of the
        //closure required by `anotherThing()` and tells us we need to allow our own completion
        //closure to be @escaping too.  `anotherThing`'s completion block will be retained in memory until
        //it is executed, so our completion closure must explicitely do the same.
        runAsyncTask {
            completion()
        }
    }
    
    func runAsyncTask(completion: @escaping (() -> Void)) {
        DispatchQueue.main.async
        {
            completion()
        }
    }
}
//    public func data(at: URL, completion: (Data?, Error?) -> ()) {
//
//    }
//}

protocol NetworkService {
    func data(at url: URL, completion: @escaping (Data?, Error?) -> Void)
}
