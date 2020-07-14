//
//  APIHandler.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 07/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import ObjectMapper

extension RegisterEndPoint {
  
  func handle(data : Any) -> AnyObject? {
    
    switch self {
    case .register(_) :
        let object  = Mapper<UserData>().map(JSONObject: data)
        UserSingleton.shared.loggedInUser = object
        return object
    default:
      return data as AnyObject
    }
  }
}

extension SMSEndPoint {
    func handle(data: Any) -> AnyObject? {
        switch self {
        default:
            return data as AnyObject
        }
    }
}

extension BookingEndPoint {
    func handle(data: Any) -> AnyObject? {
        switch self {
        default:
            return data as AnyObject
        }
    }
}
