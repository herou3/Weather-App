//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 02.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import SnapKit
import KRProgressHUD
import LBTAComponents

class WeatherDetailView: UIView {
    
    // MARK: - Init WeatherDetailView
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Create UI elements
    private var weatherDescriptionImageView: CachedImageView = {
        var imageView: CachedImageView = CachedImageView()
        ///imageView.image = #imageLiteral(resourceName: "defaultWeather-icon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let degreesWeatherLabel: UILabel = {
        var degreesLabel: UILabel = UILabel()
        degreesLabel.translatesAutoresizingMaskIntoConstraints = false
        degreesLabel.textColor = UIColor.carmine
        degreesLabel.font = UIFont.systemFont(ofSize: 32)
        return degreesLabel
    }()

    // MARK: - Configurate WeatherDetailView
    
    private  func addWeatherDescriptionImageView() {
        addSubview(weatherDescriptionImageView)
        weatherDescriptionImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(Constant.marginLeftAndRightValue)
            make.left.equalTo(self).offset(Constant.marginLeftAndRightValue)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
    }
    
    private func addDegreesWeatherLabel() {
        addSubview(degreesWeatherLabel)
        degreesWeatherLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weatherDescriptionImageView.snp.top).offset(Constant.marginLeftAndRightValue)
            make.left.equalTo(weatherDescriptionImageView.snp.right).offset(Constant.marginLeftAndRightValue)
            make.right.equalTo(self).offset(-Constant.marginLeftAndRightValue)
        }
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor.mainColor
        addWeatherDescriptionImageView()
        addDegreesWeatherLabel()
    }
}

// MARK: - Configurate data for DescriptionLocationView
extension WeatherDetailView {
    func configurateDataForDescriptionLocationView(weatherImage: String,
                                                   weatherDegree: String?) {
        if weatherDegree != "" ||
            weatherDegree != nil {
            degreesWeatherLabel.text = weatherDegree
        } else {
            degreesWeatherLabel.text = "-"
        }
        if weatherImage != nil {
            weatherDescriptionImageView.loadImage(urlString: weatherImage)
        }
    }
}
