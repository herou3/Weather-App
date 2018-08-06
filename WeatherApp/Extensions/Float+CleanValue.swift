//
//  Float+CleanValue.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 05.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import Foundation

extension Float {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.3f", self) : String(self)
    }
}
