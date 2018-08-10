//
//  Alert.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 10.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import UIKit

struct Alert {
    
    // MARK: - Show default alert
    static func showBasicAlert(on vicewController: UIViewController,
                               with title: String,
                               message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vicewController.present(alert, animated: true)
    }
}
