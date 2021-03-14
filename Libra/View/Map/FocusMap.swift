//
//  Map.swift
//  Libra
//
//  Created by Catalina on 5/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

//

import SwiftUI
import MapKit

struct FocusMapView: View {
    private let viewModel = FocusMapViewModel()
    // Pass a location to the map
    @Binding var place: PlaceOnMap?
    
    var body: some View {
        Map(coordinateRegion: , interactionModes: .all)
    }
}



// MapBox implementation
/*
struct MapView: UIViewRepresentable {
    private let mapView: MGLMapView = MGLMapView(frame: .zero, styleURL: MGLStyle.streetsStyleURL)

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MGLMapView {
        return mapView
    }

    func updateUIView(_ uiView: MGLMapView, context: UIViewRepresentableContext<MapView>) {
        
    }
    
    func styleURL(_ styleURL: URL) -> MapView {
            mapView.styleURL = styleURL
            return self
    }
    
    func centerCoordinate(_ centerCoordinate: CLLocationCoordinate2D) -> MapView {
        mapView.centerCoordinate = centerCoordinate
        return self
    }

    func zoomLevel(_ zoomLevel: Double) -> MapView {
        mapView.zoomLevel = zoomLevel
        return self
    }
}
*/

struct FocusMap_Previews: PreviewProvider {
    static var previews: some View {
        FocusMapView(place: .constant(nil))
    }
}
