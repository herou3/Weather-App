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
    let mapTrackingButton: UIButton = {
        let trackImage = #imageLiteral(resourceName: "locate-icon")
        let trackingButton = UIButton(type: UIButtonType.custom)
        trackingButton.frame = CGRect(origin: CGPoint(x: Constant.marginLeftAndRightValue,
                                                      y: Constant.marginLeftAndRightValue * 2),
                                      size: CGSize(width: 40,
                                                   height: 40))
        trackingButton.setImage(trackImage,
                                for: .normal)
        trackingButton.backgroundColor = .clear
        return trackingButton
    }()
    
    private func configurateWorldMapView() {
        let region = MKCoordinateRegion(center: Constant.coordinatesOfParis,
                                        span: MKCoordinateSpan(latitudeDelta: Constant.latitudeDeltaValue * 2,
                                                               longitudeDelta: Constant.longitudeDeltaValue * 2))
        self.setRegion(region, animated: true)
        self.addSubview(mapTrackingButton)
    }
}
