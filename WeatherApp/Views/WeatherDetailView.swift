//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 02.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import SnapKit
import KRProgressHUD

class WeatherDetailView: UIView {
    
    var imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Init WeatherDetailView
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Create UI elements
    private var weatherDescriptionImageView: ImageLoader = {
        var imageView: ImageLoader = ImageLoader()
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

    // MARK: - Configure WeatherDetailView
    
    private  func addWeatherDescriptionImageView() {
        addSubview(weatherDescriptionImageView)
        weatherDescriptionImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self).offset(Constant.marginLeftAndRightValue)
            make.left.equalTo(self).offset(Constant.marginLeftAndRightValue)
            make.height.equalTo(Constant.briefInformationHightValue)
            make.width.equalTo(100)
        }
    }
    
    private func addDegreesWeatherLabel() {
        addSubview(degreesWeatherLabel)
        degreesWeatherLabel.snp.makeConstraints { (make) in
            make.top.equalTo(weatherDescriptionImageView.snp.top).offset(Constant.briefInformationHightValue/2 -
                                                                         degreesWeatherLabel.font.pointSize/2)
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

// MARK: - Configure data for DescriptionLocationView
extension WeatherDetailView {
    func configureDataForDescriptionLocationView(weatherImage: String,
                                                   weatherDegree: String?) {
        if weatherDegree != "" ||
            weatherDegree != nil {
            degreesWeatherLabel.text = weatherDegree
        } else {
            degreesWeatherLabel.text = "-"
        }
        if weatherImage != nil {
            let imageUrl = URL(string: weatherImage) ?? URL(fileURLWithPath: "defaultWeather-icon")
            weatherDescriptionImageView.loadImageWithUrl(imageUrl)
        }
    }
}
