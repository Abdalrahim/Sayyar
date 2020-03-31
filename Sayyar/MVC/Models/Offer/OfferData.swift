//
//  OfferData.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 01/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import GoogleMaps

struct OfferData : Identifiable {
    var id = UUID()
    
    var driverName : String
    var rating : Double
    var carMake : String
    var carModel : String
    var carYear : Int
    var distance : Double
    var timeDistance : Double
    var price : Double
    var time : CGFloat
    var location : CLLocationCoordinate2D
    var isTaxi : Bool?
}

