//
//  FetchDirectionsRequest.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 10/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//


import Alamofire
import Firebase
import SwiftUI
import GoogleMaps


class FetchDirectionsRequest  {
    
    class func getDirections(from: String, destinations: [Place], completion : @escaping (_ routes: GMSPath?) -> Void ) { 
        
        let GOOGLE_MAP_DIRCTIONS = "https://maps.googleapis.com/maps/api/directions/json?"
        
        var waypoints = ""
        var destination = ""
        
        for (index, coordinates) in destinations.enumerated() {
            if index == destinations.count - 1 {
                destination = "destination=\(coordinates.lat),\(coordinates.lng)"
            } else if index == 0 {
                waypoints.append("&waypoints=via:\(coordinates.lat)%2C\(coordinates.lng)")
            } else {
                waypoints.append("%7Cvia:\(coordinates.lat)%2C\(coordinates.lng)")
            }
        }
        
        let origin = "origin=\(from)"
        
        let url = "\(GOOGLE_MAP_DIRCTIONS)\(origin)&\(destination)\(waypoints)&mode=driving&key=\(GMSApiKey)"
        print(url)
        Alamofire.SessionManager.default.request(url, method: .get, encoding: JSONEncoding.default, headers: [:]).responseJSON { (response) in
            if let value = response.value {
                DispatchQueue.main.async {
                    if let dataDic = value as? NSDictionary {
                        if let routes = dataDic["routes"] as? NSArray{
                            for theRoute in routes {
                                if let route = theRoute as? NSDictionary,
                                    let routeOverviewPolyline = route["overview_polyline"] as? NSDictionary,
                                    let points = routeOverviewPolyline["points"] as? String {
                                    
                                    guard let gpath = GMSPath.init(fromEncodedPath: points) else {
                                        return
                                    }
                                    completion(gpath)
                                }
                            }
                        }
                    }
                }
            } else {
                print(response.result)
            }
        }
    }
}

class Place {
    var lat:Double
    var lng:Double
    var stringLocation: String
    var placeName: String?
    
    init(lat:Double, lng:Double) {
        self.lat = lat
        self.lng = lng
        self.stringLocation = "\(lat),\(lng)"
    }
    
}
