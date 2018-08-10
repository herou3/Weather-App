//
//  WeatherDetailController.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 02.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import LBTAComponents
import SnapKit
import KRProgressHUD

class WeatherDetailController: UIViewController {
    
    // MARK: - Properties
    private let weatherDetailView = WeatherDetailView()
    private var weatherTableView: UITableView = UITableView()
    private var weatherDictionary = [String: String]()
    private var heightNavBar: CGFloat = 0
    private var weatherByCity: WeatherByCity?
    public var curentLocation: Location?
    private var networkService = NetworkServiceImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAndRefreshRecipesData()
        heightNavBar = (self.navigationController?.navigationBar.frame.height)!
        configurateWeatherDetailController()
    }
    
    init(location: Location) {
        self.curentLocation = location
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configurate WeatherDetailController
    private func addWeatherDetailView() {
        self.view.addSubview(weatherDetailView)
        weatherDetailView.snp.makeConstraints { (make) in
            guard let heightNavBar = self.navigationController?.navigationBar.frame.height else { return }
            make.top.equalTo(self.view.snp.top).offset(heightNavBar + 16)
            make.left.equalTo(self.view.snp.left)
            make.height.equalTo(132)
            make.right.equalTo(self.view.snp.right)
        }
    }
    
    private func addWeatherTableView() {
        weatherTableView = UITableView(frame: CGRect(x: 0,
                                                     y: heightNavBar + 148,
                                                     width: self.view.frame.width,
                                                     height: self.view.frame.height))
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.backgroundColor = .mainColor
        self.view.addSubview(weatherTableView)
    }
    
    private func configurateNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.cardinal
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = curentLocation?.city
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(cancelWeatherDetailView))
    }
    
    private func configurateWeatherDetailController() {
        self.view.backgroundColor = UIColor.mainColor
        configurateNavigationBar()
        addWeatherDetailView()
        addWeatherTableView()
    }
    
    // MARK: - Load serviceData
    private func loadAndRefreshRecipesData() {
        let urlString: String? = curentLocation?.city?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let city = urlString ?? ""
        if ReachabilityConnect.isConnectedToNetwork() {
            guard let weatherRequestURL = URL(string:"\(Constant.baseUrl)?APPID=\(NetworkAccess.appId)&q=\(city)") else { return }
            KRProgressHUD.show()
            networkService.featchHomeFeed(at: weatherRequestURL) { (resposeModel, error) in
                print("Hello")
                if resposeModel != nil {
                    self.weatherByCity = resposeModel
                    DispatchQueue.main.async {
                        self.updateDataWeather(pressureValue: self.weatherByCity?.main?.pressure,
                                               humidityValue: self.weatherByCity?.main?.humidity,
                                               windValue: self.weatherByCity?.wind?.speed,
                                               quantityOfCloudsValue: self.weatherByCity?.clouds?.all,
                                               visibilityValue: self.weatherByCity?.visibility,
                                               weatherUrl: self.weatherByCity?.weather?.first?.icon,
                                               weatherTemp: self.weatherByCity?.main?.temp)
                        self.weatherTableView.reloadData()
                        KRProgressHUD.dismiss()
                        print(error ?? "we")
                    }
                } else {
                    DispatchQueue.main.async {
                        let errorMessage = error?.message ?? ""
                        let errorCode: String = "Error \(error?.code ?? 0)"
                        KRProgressHUD.dismiss()
                        Alert.showBasicAlert(on: self, with: errorCode, message: errorMessage)
                    }
                }
                print("Test")
            }
        } else {
            Alert.showBasicAlert(on: self, with: "Oops, you have problem", message: "The Internet connection appears to be offline")
        }
    }
    
    private func updateDataWeather(pressureValue: Double?,
                                   humidityValue: Int?,
                                   windValue: Double?,
                                   quantityOfCloudsValue: Int?,
                                   visibilityValue: Int?,
                                   weatherUrl: String?,
                                   weatherTemp: Double?) {
        if pressureValue != nil {
            weatherDictionary["Pressure"] = "\(pressureValue ?? 0) mb"
        }
        if humidityValue != nil {
            weatherDictionary["Humidity"] = "\(humidityValue ?? 0)%"
        }
        if windValue != nil {
            weatherDictionary["Wind"] = "\(windValue ?? 0) km/h"
        }
        if quantityOfCloudsValue != nil {
            weatherDictionary["QuantityOfClouds"] = "\(quantityOfCloudsValue ?? 0)%"
        }
        if visibilityValue != nil {
            weatherDictionary["Visibility"] = "\(visibilityValue ?? 0) km"
        }
        let imageUrl = "http://openweathermap.org/img/w/\(weatherUrl ?? "03d").png"
        guard let fTempDouble = weatherTemp else { return }
        let celsiusTempDouble = fTempDouble - Constant.kelvinTemperatureZero
        let celsiusTempString = "\(String(format: "%.0f", celsiusTempDouble)) °C"
        weatherDetailView.configurateDataForDescriptionLocationView(weatherImage: imageUrl, weatherDegree: celsiusTempString)
        weatherTableView.reloadData()
    }
    
    @objc private func cancelWeatherDetailView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - DetectedInternetConnection
    private func setupRecipeImage(recipeImage: String?) -> CachedImageView {
        if let recipeImageViewURL = recipeImage {
            let imageView = CachedImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.loadImage(urlString: recipeImageViewURL)
            return imageView
        }   else {
            let imageView = CachedImageView()
            imageView.image = #imageLiteral(resourceName: "defaultWeather-icon")
            return imageView
        }
    }
}

// MARK: - Table DataSource
extension WeatherDetailController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return weatherDictionary.count
    }
    
    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = Array(weatherDictionary)[indexPath.section].value
        cell.backgroundColor = UIColor.mainColor
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView,
                   willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        tableView.deselectRow(at: indexPath, animated: true)
        return indexPath
    }
}

// MARK: - TableView Delegate
extension WeatherDetailController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .orange
        
        let label = UILabel()
        label.text = Array(weatherDictionary)[section].key
        label.frame = CGRect(x: 8, y: 0, width: self.view.frame.width, height: 25)
        view.addSubview(label)
        
        return view
    }
}
