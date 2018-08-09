//
//  WeatherDownloadService.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

protocol WeatherDownloadService {
    
    func data(at url: URL, completion: @escaping (WeatherByCity?) -> Void)
}
