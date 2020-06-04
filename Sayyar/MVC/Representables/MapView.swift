//
//  MapView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//


import SwiftUI
import GoogleMaps
import MapKit
import Firebase
import UIKit

struct MapView: UIViewRepresentable {
    
    @ObservedObject var locationManager = LocationManager()
    
    typealias UIViewType = GMSMapView
    
    let map = GMSMapView(frame: .zero)
//    private var renderer: GMUGeometryRenderer!
    
    let db = Firestore.firestore()
    
    @State var updated : Bool = false
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> GMSMapView {
        map.delegate = context.coordinator
        map.settings.myLocationButton = false
        map.isMyLocationEnabled = true
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "mapstyle", withExtension: "json") {
                map.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        return map
    }
    
    func drawLines() {
        self.map.clear()
        let path = GMSMutablePath()
        
        LocationsStorage.shared.locations .forEach { (location) in
            path.add(location.coordinates)
        }
        let polyline = GMSPolyline.init(path: path)
        
        polyline.strokeWidth = 3
        polyline.strokeColor = .darkGray
        polyline.map = self.map
    }
    
    func updateUIView(_ uiView: MapView.UIViewType, context: UIViewRepresentableContext<MapView>) {
        //MARK: - Remove when deployed to APP Store
        if locationManager.latitude == 0 && locationManager.longitude == 0 {
            let camera = GMSCameraPosition(latitude: 21.553583299752678, longitude: 39.18819702956502, zoom: 15)
            uiView.animate(to: camera)
            return
        }
        
        let camera = GMSCameraPosition(latitude: locationManager.latitude, longitude: locationManager.longitude, zoom: 15)
        uiView.animate(to: camera)
    }
    
    func addMarker(marker: GMSMarker){
        marker.map = map
    }
    
//    func updateLocation(location : CLLocation){
//        
//        // No delegate in here to update location
//        
//        let geo = GeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        guard let id = UserSingleton.shared.loggedInUser?.userData?.userId else {
//            return
//        }
//        self.db.collection("trips").document("taxi2381").updateData(
//            [
//                "driverlocation": FieldValue.arrayUnion([geo])
//            ]
//        ) { error in
//            if let err = error {
//                debugPrint("Error writing document: \(err)")
//            } else {
//
//            }
//        }
//    }
    
    func update(location: CLLocation) {
        let cord = location.coordinate
        
        let camera = GMSCameraPosition(target: cord, zoom: 16)
//        self.updateLocation(location: location)
        self.drawLines()
        if !self.updated {
            map.animate(to: camera)
            self.updated = true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, GMSMapViewDelegate {
        
        var map : MapView
        
        init(_ map : MapView) {
            self.map = map
        }
        
        func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
            print(marker.position)
            return true
        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView().edgesIgnoringSafeArea(.all)
    }
}
