//
//  WeatherDetailController.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 02.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import SnapKit
import KRProgressHUD

class WeatherDetailController: UIViewController {
    
    // MARK: - Properties
    private let weatherDetailView = WeatherDetailView()
    private var weatherTableView: UITableView = UITableView()
    private var weatherDictionary = [String: String]()
    private var weatherByCity: WeatherByCity?
    public var curentLocation: Location?
    private var networkService = NetworkServiceImpl()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = curentLocation?.city
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAndRefreshRecipesData()
        configureWeatherDetailController()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    init(location: Location) {
        self.curentLocation = location
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure WeatherDetailController
    private func addWeatherDetailView() {
        self.view.addSubview(weatherDetailView)
        weatherDetailView.snp.makeConstraints { (make) in
            make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(-Constant.marginLeftAndRightValue)
            make.left.equalTo(self.view.snp.left)
            make.height.equalTo(Constant.briefInformationHightValue)
            make.right.equalTo(self.view.snp.right)
        }
    }
    
    private func addWeatherTableView() {
        
        self.view.addSubview(weatherTableView)
        weatherTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.weatherDetailView.snp.bottom).offset(Constant.marginLeftAndRightValue)
            make.left.equalTo(self.view.snp.left)
            make.bottom.equalTo(self.view.snp.bottom)
            make.right.equalTo(self.view.snp.right)
        }
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.backgroundColor = .mainColor
        weatherTableView.tableFooterView = UIView()
        weatherTableView.separatorStyle = .none
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .cardinal
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = curentLocation?.city
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(cancelWeatherDetailView))
    }
    
    private func configureWeatherDetailController() {
        self.view.backgroundColor = UIColor.mainColor
        configureNavigationBar()
        addWeatherDetailView()
        addWeatherTableView()
    }
    
    // MARK: - Load serviceData
    private func loadAndRefreshRecipesData() {
        let urlString: String? = curentLocation?.city?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let city = urlString ?? ""
        guard ReachabilityConnect.isConnectedToNetwork() else {
            Alert.showBasicAlert(on: self, with: "Oops, you have problem",
                                 message: "The Internet connection appears to be offline")
            return
        }
        guard let weatherRequestURL = URL(string:"\(Constant.baseUrl)?APPID=\(NetworkAccess.appId)&q=\(city)") else {
            return
        }
        KRProgressHUD.show()
        networkService.featchHomeFeed(at: weatherRequestURL) { (resposeModel, error) in
            if resposeModel != nil {
                self.weatherByCity = resposeModel
                DispatchQueue.main.async {
                    let weatherBrief: WeatherBrief =
                        WeatherBrief(pressureValue:
                            self.weatherByCity?.weatherMainInformation?.pressure,
                                                                  humidityValue:
                            self.weatherByCity?.weatherMainInformation?.humidity,
                                                                  windValue:
                            self.weatherByCity?.wind?.speed,
                                                                  quantityOfCloudsValue:
                            self.weatherByCity?.clouds?.percentOfTheCloud,
                                                                  visibilityValue:
                            self.weatherByCity?.visibility)
                    self.updateDataWeather(weatherBrief: weatherBrief,
                                           weatherUrl: self.weatherByCity?.weatherBriefInformation?.first?.icon,
                                           weatherTemp: self.weatherByCity?.weatherMainInformation?.temp)
                    self.weatherTableView.reloadData()
                    KRProgressHUD.dismiss()
                }
            } else {
                DispatchQueue.main.async {
                    let errorMessage = error?.message ?? ""
                    let errorCode: String = "Error \(error?.code ?? 0)"
                    KRProgressHUD.dismiss()
                    Alert.showBasicAlert(on: self, with: errorCode, message: errorMessage)
                }
            }
        }
    }
    
    // MARK: - update information about weather
    private func updateDataWeather(weatherBrief: WeatherBrief,
                                   weatherUrl: String?,
                                   weatherTemp: Double?) {
        if weatherBrief.pressureValue != nil {
            weatherDictionary["Pressure"] = "\(weatherBrief.pressureValue ?? 0) mb"
        }
        if weatherBrief.humidityValue != nil {
            weatherDictionary["Humidity"] = "\(weatherBrief.humidityValue ?? 0)%"
        }
        if weatherBrief.windValue != nil {
            weatherDictionary["Wind"] = "\(weatherBrief.windValue ?? 0) km/h"
        }
        if weatherBrief.quantityOfCloudsValue != nil {
            weatherDictionary["Clouds"] = "\(weatherBrief.quantityOfCloudsValue ?? 0)%"
        }
        if weatherBrief.visibilityValue != nil {
            weatherDictionary["Visibility"] = "\(weatherBrief.visibilityValue ?? 0) m"
        }
        let imageUrl = "http://openweathermap.org/img/w/\(weatherUrl ?? "03d").png"
        guard let fTempDouble = weatherTemp else { return }
        let celsiusTempDouble = fTempDouble - Constant.kelvinTemperatureZero
        let celsiusTempString = "\(String(format: "%.0f", celsiusTempDouble)) °C"
        weatherDetailView.configureDataForDescriptionLocationView(weatherImage: imageUrl, weatherDegree: celsiusTempString)
        weatherTableView.reloadData()
    }
    
    @objc private func cancelWeatherDetailView() {
        self.dismiss(animated: true, completion: nil)
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
        cell.textLabel?.textColor = UIColor.carmine
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
        view.backgroundColor = .cardinal
        
        let label = UILabel()
        label.text = Array(weatherDictionary)[section].key
        label.textColor = .white
        label.frame = CGRect(x: 8, y: 0, width: self.view.frame.width, height: 25)
        view.addSubview(label)
        
        return view
    }
}
