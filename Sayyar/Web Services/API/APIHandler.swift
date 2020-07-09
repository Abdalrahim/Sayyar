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
        let object  = Mapper<UserModel>().map(JSONObject: data)
        UserSingleton.shared.loggedInUser = object
        return object
    default:
      return data as AnyObject
    }
  }
}
