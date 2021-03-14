//
//  FocusMapViewModel.swift
//  Libra
//
//  Created by Catalina on 9/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import MapKit

class FocusMapViewModel {
    private let locationManager = LocationManager()
    
    func coordinateRegion(of place: PlaceOnMap?) -> MKCoordinateRegion {
        if let place = place {
            return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude), span: MKCoordinateSpan(latitudeDelta: Constants.coordinateDelta, longitudeDelta: Constants.coordinateDelta))
        } else {
            return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locationManager.currentCoordinate?.latitude ?? 0, longitude: locationManager.currentCoordinate?.longitude ?? 0), span: MKCoordinateSpan(latitudeDelta: Constants.coordinateDelta, longitudeDelta: Constants.coordinateDelta))
        }
    }
}
