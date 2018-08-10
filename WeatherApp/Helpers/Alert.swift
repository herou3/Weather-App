//
//  Alert.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 10.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

struct Alert {
    
    static func showBasicAlert(on vc: UIViewController,
                               with title: String,
                               message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}