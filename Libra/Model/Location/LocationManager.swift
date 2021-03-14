//
//  LocationManager.swift
//  Libra
//
//  Created by Catalina on 6/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject {
    private let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D?
        
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
  
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentCoordinate = locations.first?.coordinate
    }
    

    
    
    
}
