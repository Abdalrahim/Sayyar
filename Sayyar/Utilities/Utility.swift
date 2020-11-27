//
//  Utility.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Foundation
import SafariServices
import MapKit

typealias success = (_ coordinates: CLLocationCoordinate2D, _ fullAddress: String?, _ name : String?, _ city : String?,_ state : String?, _ subLocality: String? , _ country : String? ) -> ()

typealias uniqueCheckBlock = (_ unqiueModel : UniqueCheckModel) -> ()

class Utility: NSObject {

    //MARK: - --------------Variables-----------------
    static let shared = Utility()
    let geoCoder = CLGeocoder()
    
    
    //MARK: - -----------------Initializer----------------
    override init() {
        super.init()
    }
    
    //MARK: - -------------calculate address from Lat long---------------------
    func calculateAddress(lat : CLLocationDegrees , long : CLLocationDegrees , responseBlock : @escaping success) {
        
        geoCoder.reverseGeocodeLocation(CLLocation(latitude: lat, longitude: long), preferredLocale: Locale(identifier: "en")) { (placemarks, error) in
            
            
            let placeMark = placemarks?[0]
            guard let address = placeMark?.addressDictionary?["FormattedAddressLines"] as? [String] else {return}
            let fullAddress = address.joined(separator: ", ")
            
            let name = placeMark?.addressDictionary?["Name"] as? String
            let city = placeMark?.addressDictionary?["City"] as? String
            
            let state = placeMark?.addressDictionary?["State"] as? String
            let subLocality = placeMark?.addressDictionary?["SubLocality"] as? String
            
            let country = placeMark?.addressDictionary?["Country"] as? String
            
            responseBlock(CLLocationCoordinate2D(latitude: lat, longitude: long), fullAddress,name,city,state,subLocality, country)
            
        }
    }
    
}
