//
//  DescriptionLocationView.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 02.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import MapKit
import SnapKit

class DescriptionLocationView: UIView {
    
    // MARK: - Init DescriptionLocationView
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Create UIElements
    private let nameCityLabel: UILabel = {
        var cityLabel: UILabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.textColor = UIColor.сarmine
        cityLabel.font = UIFont.systemFont(ofSize: 20)
        return cityLabel
    }()
    
    private let coordinateLabel: UILabel = {
        var coordLabel: UILabel = UILabel()
        coordLabel.translatesAutoresizingMaskIntoConstraints = false
        coordLabel.textColor = UIColor.сarmine
        coordLabel.font = UIFont.systemFont(ofSize: 14)
        coordLabel.numberOfLines = 2
        return coordLabel
    }()
    
    private let detailWeatherButton: UIButton = {
        var detailWeatherButton: UIButton = UIButton()
        detailWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        detailWeatherButton.setTitleColor(UIColor.cardinal, for: .normal)
        detailWeatherButton.setTitle("Show weather", for: .normal)
        return detailWeatherButton
    }()
    
    // MARK: - Configurate DescriptionLocationView
    private func addNameCityLabel() {
        addSubview(nameCityLabel)
        nameCityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(16)
            make.left.equalTo(self).offset(16)
            make.right.equalToSuperview().dividedBy(2)
        }
    }
    
    private func addDetailWeatherButton() {
        addSubview(detailWeatherButton)
        detailWeatherButton.snp.makeConstraints { (make) in
            make.right.equalTo(self)
            make.left.equalTo(nameCityLabel.snp.right)
            make.top.equalTo(self).offset(16)
            make.bottom.equalTo(self).offset(-16)
        }
    }
    
    private func addCoordinateLabel() {
        addSubview(coordinateLabel)
        coordinateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameCityLabel.snp.bottom).offset(8)
            make.right.equalToSuperview().dividedBy(2)
            make.left.equalTo(self).offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.mainColor
        addNameCityLabel()
        addDetailWeatherButton()
        addCoordinateLabel()
    }
    
    // MARK: - Configurate data for DescriptionLocationView
    func configureDescriptionLocationView(cityName: String,
                                          pointCoordinate: String) {
        nameCityLabel.text = cityName
        coordinateLabel.text = pointCoordinate
    }
}
