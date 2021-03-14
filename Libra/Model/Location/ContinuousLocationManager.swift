//
//  ContinuousLocationManager.swift
//  Libra
//
//  Created by Catalina on 9/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class ContinuousLocationManager: LocationManager, ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    @Published var continuousLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }

}

extension ContinuousLocationManager {
    override func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.continuousLocation = location
    }
}
