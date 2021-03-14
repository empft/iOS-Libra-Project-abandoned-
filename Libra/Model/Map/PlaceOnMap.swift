//
//  PlaceOnMap.swift
//  Libra
//
//  Created by Catalina on 8/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import MapKit

struct PlaceOnMap: Identifiable {
    var id: UUID
    let name: String
    let type: PlaceType
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
}
