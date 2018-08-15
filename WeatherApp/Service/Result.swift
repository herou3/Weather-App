//
//  Result.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 15.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
