//
//  BookingEndPoint.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 14/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Alamofire

enum BookingEndPoint {
    
    case createOrder(destination_lat : String?, destination_lng : String?, pickup_lat : String?, pickup_lng : String?)
    
}

extension BookingEndPoint: Router {
    
    var baseURL: String {
        switch self{
        default:
            return APIBasePath.basePath + Routes.passengers
        }
        
    }
    
    var parameters: OptionalDictionary {
        return format()
    }
    
    var method: Alamofire.HTTPMethod {
      
      switch self {
      default:
        return .post
      }
    }
    
    var route: String  {
        
        switch self {
            
        case .createOrder(_):
            return APITypes.orderCreate
        }
    }
    
    func format() -> OptionalDictionary {
        switch self {
        case .createOrder(destination_lat: let destination_lat, destination_lng: let destination_lng, pickup_lat: let pickup_lat, pickup_lng: let pickup_lng):
            return Parameters.order.map(values: [destination_lat,destination_lng,pickup_lat,pickup_lng])
        }
    }
    
    
    func request(completion: @escaping Completion) {
        APIManager.init().request(with: self, completion: completion)
    }
    
    
    var header: [String : String] {
        let accessToken = TokenSingleton.shared.currentToken?.accessToken ?? ""
        
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization" : "Bearer \(accessToken)"
        ]
    }
    
}
