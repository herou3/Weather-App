//
//  WorldMapController.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 31.07.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import MapKit
import SnapKit
import KRProgressHUD
import TRON

class WorldMapController: UINavigationController {
    
    // MARK: - Property
    private let mapView = WorldMapView()
    private let descriptionLocationView = DescriptionLocationView()
    private var locationManager: CLLocationManager = CLLocationManager()
    private var geocoder: CLGeocoder = CLGeocoder()
    private var pointAnotations: [MKPointAnnotation] = []
    private var placemarks: [CLPlacemark] = [] {
        didSet {
            addPointInMap()
        }
    }
    private var isFindedLocality: Bool = false {
        didSet {
            if isFindedLocality {
                self.showDescriptinLocationView()
            } else {
                self.hideDescriptinLocationView()
            }
        }
    }
    private var location: Location = Location()
    private var networkServiceFL = NetworkServiceFL()
    //private var networkService: NetworkServiceImpl = NetworkServiceImpl(session: URLSession)
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateWorldMapController()
        configurateLocationManager()
        let configGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(addPlacemarkAfterTouchToScreen(sender:)))
        configGesture.numberOfTapsRequired = 1
        configGesture.numberOfTouchesRequired = 1
        mapView.addGestureRecognizer(configGesture)
        mapView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Configurate location manager
    private func configurateLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Configurate WorldMapController
    private func addWorldMapView() {
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.bottom.equalTo(self.view.snp.bottom)
            make.right.equalTo(self.view.snp.right)
        }
    }
    
    private func addDescriptionLocationView() {
        self.mapView.addSubview(descriptionLocationView)
        descriptionLocationView.snp.makeConstraints { (make) in
            make.left.equalTo(mapView).offset(20)
            make.right.equalTo(mapView).offset(-20)
            make.bottom.equalTo(mapView).offset(100)
            make.height.equalTo(100)
        }
        descriptionLocationView.isHidden = true
    }
    
    private func configurateWorldMapController() {
        addWorldMapView()
        addDescriptionLocationView()
    }
    
    // MARK: - Show and hide DescriptionLocationView
    private func hideDescriptinLocationView() {
        self.descriptionLocationView.snp.updateConstraints { (make) in
            make.bottom.equalTo(mapView).offset(100)
        }
        UIView.animate(withDuration: 0.5) {
            self.mapView.layoutIfNeeded()
        }
        self.descriptionLocationView.isHidden = true
    }
    
    private func showDescriptinLocationView() {
        self.descriptionLocationView.snp.updateConstraints { (make) in
            make.bottom.equalTo(mapView).offset(-20)
        }
        self.descriptionLocationView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.mapView.layoutIfNeeded()
        }
        descriptionLocationView.detailWeatherButton.addTarget(self,
                                                              action: #selector(pushDetailViewContorller),
                                                              for: .touchUpInside)
    }
    
    // MARK: - Add point in Map
    func addPointInMap() {
        let pointAnotation = MKPointAnnotation()
        pointAnotation.title = placemarks.first?.name
        guard let coordinate = placemarks.first?.location?.coordinate else { return }
        pointAnotation.coordinate = coordinate
        pointAnotations.removeAll()
        pointAnotations.append(pointAnotation)

        mapView.addAnnotations(pointAnotations)
        mapView.showAnnotations(pointAnotations, animated: true)
    }
    
    // MARK: - Gestures
    @objc func addPlacemarkAfterTouchToScreen(sender: UITapGestureRecognizer) {
        let location = sender.location(in: mapView)
        let locationCoord = self.mapView.convert(location, toCoordinateFrom: mapView)
        let locationForPlacemark = CLLocation(latitude: locationCoord.latitude, longitude: locationCoord.longitude)
        let placemark = MKPlacemark.init(coordinate: locationCoord)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locationCoord
        annotation.title = placemark.locality
        annotation.subtitle = placemark.title
        
        clearMapAnotations()
        placemarks.removeAll()

        self.checkInformationAboutPlacemark(location: locationForPlacemark)
    }
    
    // MARK: - Internal function
    private func clearMapAnotations() {
        self.mapView.removeAnnotations(mapView.annotations)
    }
    
    private func checkInformationAboutPlacemark(location: CLLocation) {
        KRProgressHUD.show()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print(error?.localizedDescription ?? "def error")
            }
            guard (placemarks as? [CLPlacemark]) != nil else {
                if error != nil {
                    print(error?.localizedDescription ?? "unknown error")
                    KRProgressHUD.showError()
                }
                return
            }
            if let placemark = placemarks?.first {
            self.placemarks.insert(placemark, at: 0)
            if placemark.locality != nil && placemark.location?.coordinate != nil {
                self.isFindedLocality = true
                
                guard let locality = placemark.locality else { return }
                guard let latitude = placemark.location?.coordinate.latitude else { return }
                guard let longitude = placemark.location?.coordinate.longitude else { return }
                
                self.location.city = locality
                self.location.lat = CGFloat(latitude)
                self.location.lon = CGFloat(longitude)
                
                let coordinateString = String(
                    "lat:\(Float(self.location.lat!).cleanValue) long:\(Float(self.location.lon!).cleanValue)"
                )
                self.descriptionLocationView.configureDescriptionLocationView(cityName: self.location.city!,
                                                                               pointCoordinate: coordinateString)
            } else {
                self.isFindedLocality = false
                }
            }
            KRProgressHUD.dismiss()
        }
    }
    
    // MARK: - Present WeatherDetailController
    @objc func pushDetailViewContorller() {
        let weatherDetailController = WeatherDetailController(location: self.location)
        weatherDetailController.curentLocation = location
        let navController = UINavigationController(rootViewController: weatherDetailController)
        self.present(navController, animated: true, completion: nil)
    }
}

// MARK: - extension CLLocationManagerDelegate
extension WorldMapController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            KRProgressHUD.show()
            locationManager.requestLocation()
        default:
            print("")
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.checkInformationAboutPlacemark(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        let alert = UIAlertController(title: error.localizedDescription,
                                      message: nil,
                                      preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil)
        alert.addAction(actionCancel)
        KRProgressHUD.dismiss()
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}
