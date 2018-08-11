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
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { (_) in
            vicewController.dismiss(animated: true,
                                    completion: nil)
        }))
        vicewController.present(alert,
                                animated: true)
    }
    
    static func showAcessDeniedAlert(on vicewController: UIViewController,
                                     with title: String,
                                     message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings",
                                      style: .default,
                                      handler: { (_) in
            if let appSettings = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(appSettings as URL)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .default,
                                      handler: nil))
        vicewController.present(alert,
                                animated: true)
    }
}
