//
//  NetworkTask.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 09.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

class NetworkTask {
    
    private var urlSessionTask = URLSessionTask()
    
    public init(urlSessionTask: URLSessionTask) {
        self.urlSessionTask = urlSessionTask
    }
    
}
