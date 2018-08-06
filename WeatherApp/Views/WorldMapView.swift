//
//  WorldMapView.swift
//  WeatherApp
//
//  Created by Pavel Kurilov on 02.08.2018.
//  Copyright © 2018 Pavel Kurilov. All rights reserved.
//

import SnapKit
import MapKit

class WorldMapView: MKMapView {
    
    // MARK: - init WorldMapView
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurateWorldMapView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configurate WorldMapView
    private func configurateWorldMapView() {
        let region = MKCoordinateRegion(center: Constant.coordinatesOfParis,
                                        span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.setRegion(region, animated: true)
    }
}
