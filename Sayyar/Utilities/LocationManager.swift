//
//  LocationManager.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import UIKit
import CoreLocation
import EZSwiftExtensions
import Firebase
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    
    var latitude: CLLocationDegrees {
        return location?.coordinate.latitude ?? 0
    }
    
    var longitude: CLLocationDegrees {
        return location?.coordinate.longitude ?? 0
    }
    
    var currentCity : String?
    var country : String?
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = false
//        locationManager.performSelector(inBackground: T##Selector, with: T##Any?)
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
    }
    
    @Published var location: CLLocation? {
       willSet { objectWillChange.send() }
     }
    
    func updateLocation() {
        
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startMonitoringVisits()
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .authorizedWhenInUse,.authorizedAlways:
            locationManager.startUpdatingLocation()
            
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            
        case .restricted,.denied:
            settingsAlert()
        default:
            break
        }
    }
    
    func settingsAlert() {
        //Alerts.shared.showAlertView(alert: Alert.alert.getLocalised(), message: "alert.TurnOnLocationPermission".localized, buttonTitles: ["buttonTitle.settings".localized ], viewController: ez.topMostVC!)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
          return
        }
        
        self.location = location
        
        AppDelegate.geoCoder.reverseGeocodeLocation(location) { placemarks, _ in
          if let place = placemarks?.first {
            let description = "Fake visit: \(place)"
            let fakeVisit = FakeVisit(coordinates: location.coordinate, arrivalDate: Date(), departureDate: Date())
            self.newVisitReceived(fakeVisit, description: description)
          }
        }
        
        if self.latitude != 0 && self.longitude != 0 {
            getUserCurrentCity()
        }
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
      // create CLLocation from the coordinates of CLVisit
      let clLocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
      
      // Get location description
      AppDelegate.geoCoder.reverseGeocodeLocation(clLocation) { placemarks, _ in
        if let place = placemarks?.first {
          let description = "\(place)"
            print(description)
            self.newVisitReceived(visit, description: description)
        }
      }
    }
    
    
    func newVisitReceived(_ visit: CLVisit, description: String) {
        
      let location = Location(visit: visit, descriptionString: description)
        
      LocationsStorage.shared.saveLocationOnDisk(location)
      
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    //MARK: - Delegate City Fire
    func updateLocationForCurrentCity() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch(CLLocationManager.authorizationStatus()) {
                
            case  .restricted, .denied:
                settingsAlert()
                
            case .authorizedAlways, .authorizedWhenInUse:
                self.getUserCurrentCity()
                
            case .notDetermined:
                break
            default:
                break
            }
        } else {
            
            debugPrint("Location services are not enabled")
            
        }
    }
    
    func getUserCurrentCity() {
        
        if latitude == 0  || longitude == 0  {
            
            ez.runThisAfterDelay(seconds: 0.1, after: { [weak self] in
                self?.getUserCurrentCity()
            })
            
        } else {
            
            Utility.shared.calculateAddress(lat: LocationManager.shared.latitude, long: LocationManager.shared.longitude, responseBlock: { [weak self] (coordinate, fullAddress, name, city, state, subLocality , country) in
                
                self?.currentCity = city
                self?.country = country
                
            })
            
            return
        }
    }
}

final class FakeVisit: CLVisit {
  private let myCoordinates: CLLocationCoordinate2D
  private let myArrivalDate: Date
  private let myDepartureDate: Date

  override var coordinate: CLLocationCoordinate2D {
    return myCoordinates
  }
  
  override var arrivalDate: Date {
    return myArrivalDate
  }
  
  override var departureDate: Date {
    return myDepartureDate
  }
  
  init(coordinates: CLLocationCoordinate2D, arrivalDate: Date, departureDate: Date) {
    myCoordinates = coordinates
    myArrivalDate = arrivalDate
    myDepartureDate = departureDate
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
