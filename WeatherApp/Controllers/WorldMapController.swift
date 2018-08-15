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

class WorldMapController: UINavigationController {
    
    // MARK: - Properties
    private let mapView = WorldMapView()
    private let descriptionLocationView = DescriptionLocationView()
    private var locationManager: CLLocationManager = CLLocationManager()
    private var geocoder: CLGeocoder = CLGeocoder()
    private var pointAnotations: [MKPointAnnotation] = []
    private var hasAuthorizationStatus: Bool = false
    private var placemarks: [CLPlacemark] = [] {
        didSet {
            addPointInMap()
        }
    }
    private var hasFoundLocality: Bool = false {
        didSet {
            if hasFoundLocality {
                self.showDescriptinLocationView()
            } else {
                self.hideDescriptinLocationView()
            }
        }
    }
    private var location: Location = Location()
    private var networkService = NetworkServiceImpl()
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWorldMapController()
        configureLocationManager()
    }
    
    // MARK: - Configure location manager
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: - Configure WorldMapController
    private func addWorldMapView() {
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.bottom.equalTo(self.view.snp.bottom)
            make.right.equalTo(self.view.snp.right)
        }
        mapView.mapTrackingButton.addTarget(self,
                                            action: #selector(centerMapOnUserButtonClicked),
                                            for: .touchUpInside)
        mapView.addGestureRecognizer(configureGesture())
        mapView.isUserInteractionEnabled = true
    }
    
    private func addDescriptionLocationView() {
        self.mapView.addSubview(descriptionLocationView)
        descriptionLocationView.snp.makeConstraints { (make) in
            make.left.equalTo(mapView).offset(Constant.marginLeftAndRightValue)
            make.right.equalTo(mapView).offset(-Constant.marginLeftAndRightValue)
            make.bottom.equalTo(mapView).offset(Constant.marginLeftAndRightValue)
            make.height.equalTo(Constant.briefInformationHightValue)
        }
        descriptionLocationView.isHidden = true
        descriptionLocationView.detailWeatherButton.addTarget(self,
                                                              action: #selector(presentDetailViewContorller),
                                                              for: .touchUpInside)
    }
    
    private func configureGesture() -> UITapGestureRecognizer {
        let configGesture = UITapGestureRecognizer(target: self,
                                                   action: #selector(addPlacemarkAfterTouchToScreen(sender:)))
        configGesture.numberOfTapsRequired = 1
        configGesture.numberOfTouchesRequired = 1
        return configGesture
    }
    
    private func configureWorldMapController() {
        addWorldMapView()
        addDescriptionLocationView()
    }
    
    // MARK: - Show and hide DescriptionLocationView
    private func hideDescriptinLocationView() {
        self.descriptionLocationView.snp.updateConstraints { (make) in
            make.bottom.equalTo(mapView).offset(Constant.briefInformationHightValue)
        }
        UIView.animate(withDuration: 0.5) {
            self.mapView.layoutIfNeeded()
        }
        self.descriptionLocationView.isHidden = true
    }
    
    private func showDescriptinLocationView() {
        self.descriptionLocationView.snp.updateConstraints { (make) in
            make.bottom.equalTo(mapView).offset(-Constant.marginLeftAndRightValue)
        }
        self.descriptionLocationView.isHidden = false
        UIView.animate(withDuration: 0.5) {
            self.mapView.layoutIfNeeded()
        }
    }
    
    // MARK: - Add point in Map
    private func addPointInMap() {
        let pointAnotation = MKPointAnnotation()
        pointAnotation.title = placemarks.first?.name
        guard let coordinate = placemarks.first?.location?.coordinate else { return }
        pointAnotation.coordinate = coordinate
        pointAnotations.removeAll()
        pointAnotations.append(pointAnotation)
        let region = MKCoordinateRegion(center: pointAnotation.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: Constant.latitudeDeltaValue,
                                                               longitudeDelta: Constant.longitudeDeltaValue))
        
        mapView.addAnnotations(pointAnotations)
        mapView.setRegion(region, animated: true)
        
    }
    
    // MARK: - Gestures
    @objc private func addPlacemarkAfterTouchToScreen(sender: UITapGestureRecognizer) {
        let location = sender.location(in: mapView)
        let locationCoord = self.mapView.convert(location, toCoordinateFrom: mapView)
        let locationForPlacemark = CLLocation(latitude: locationCoord.latitude,
                                              longitude: locationCoord.longitude)
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
                self.hasFoundLocality = true
                
                guard let locality = placemark.locality else { return }
                guard let latitude = placemark.location?.coordinate.latitude else { return }
                guard let longitude = placemark.location?.coordinate.longitude else { return }
                
                self.location.city = locality
                self.location.lat = CGFloat(latitude)
                self.location.lon = CGFloat(longitude)
                
                let coordinateString = String(
                    "lat:\(Float(self.location.lat!).cleanValue) long:\(Float(self.location.lon!).cleanValue)"
                )
                self.descriptionLocationView.configureDescriptionLocationView(cityName: locality,
                                                                               pointCoordinate: coordinateString)
            } else {
                self.hasFoundLocality = false
                }
            }
            KRProgressHUD.dismiss()
        }
    }
    
    // MARK: - centers camera over user location
    @objc private func centerMapOnUserButtonClicked() {
        if !self.hasAuthorizationStatus {
            Alert.showAcessDeniedAlert(on: self,
                                       with: "Location Accees Requested",
                                       message: "The location permission was not authorized. Please enable it in Settings")
        } else {
            mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: true)
        }
    }
    
    // MARK: - Present WeatherDetailController
    @objc private func presentDetailViewContorller() {
        let weatherDetailController = WeatherDetailController(location: self.location)
        weatherDetailController.curentLocation = location
        let navController = NavigationController(rootViewController: weatherDetailController)
        self.present(navController, animated: true, completion: nil)
    }
}

// MARK: - extension CLLocationManagerDelegate
extension WorldMapController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            Alert.showAcessDeniedAlert(on: self,
                                       with: "Location Accees Requested",
                                       message: "The location permission was not authorized. Please enable it in Settings")
            self.hasAuthorizationStatus = false
        case .notDetermined:
            Alert.showAcessDeniedAlert(on: self,
                                       with: "Location Accees Requested",
                                       message: "The location permission was not authorized. Please enable it in Settings")
            self.hasAuthorizationStatus = false
        case .authorizedWhenInUse:
            KRProgressHUD.show()
            self.hasAuthorizationStatus = true
            mapView.setUserTrackingMode(MKUserTrackingMode.follow, animated: false)
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
