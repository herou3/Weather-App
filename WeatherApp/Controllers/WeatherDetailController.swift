//
//  WeatherDetailController.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 02.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import LBTAComponents
import SnapKit

class WeatherDetailController: UIViewController {
    
    // MARK: - Property
    private let weatherDetailView = WeatherDetailView()
    private var weatherTableView: UITableView = UITableView()
    private var weatherDictionary = [String: String]()
    var heightNavBar: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateNavigationBar()
        self.view.backgroundColor = UIColor.mainColor
        weatherDetailView.configurateDataForDescriptionLocationView(weatherImage: #imageLiteral(resourceName: "defaultWeather-icon"),
                                                                    weatherDegree: "+32")
        heightNavBar = (self.navigationController?.navigationBar.frame.height)!
        configurateWeatherDetailController()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Close",
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(cancelWeatherDetailView))
        self.configurateDictonary(valueOne: "test1", valueTwo: nil, valueThree: "test3", valueFour: "", valueFive: "test5")
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
    
    private func configurateWeatherDetailController() {
        addWeatherDetailView()
        addWeatherTableView()
    }
    
    @objc private func cancelWeatherDetailView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func configurateNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.cardinal
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationItem.title = "London"
    }
    
    private func configurateDictonary(valueOne: String?,
                                      valueTwo: String?,
                                      valueThree: String?,
                                      valueFour: String?,
                                      valueFive: String?) {
        if valueOne != "" && valueOne != nil {
            weatherDictionary["Pressure"] = valueOne
        }
        if valueTwo != "" && valueTwo != nil {
            weatherDictionary["Humidity"] = valueTwo
        }
        if valueThree != "" && valueThree != nil {
            weatherDictionary["Wind"] = valueThree
        }
        if valueFour != "" && valueFour != nil {
            weatherDictionary["QuantityOfClouds"] = valueFour
        }
        if valueFive != "" && valueFour != nil {
            weatherDictionary["Visibility"] = valueFive
        }
    }
}

extension WeatherDetailController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .orange
        
        let label = UILabel()
        label.text = Array(weatherDictionary)[section].key
        label.frame = CGRect(x: 8, y: 0, width: self.view.frame.width, height: 25)
        view.addSubview(label)
        
        return view
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
