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
    case .login(_) :
        let object  = Mapper<UserData>().map(JSONObject: data)
        print("Access Token: " ,object?.tokenResponse?.accessToken)
        UserSingleton.shared.loggedInUser = object
        return object
    case .refresh(_):
        let tokenResponse  = Mapper<TokenResponse>().map(JSONObject: data)
        print("Access Token Refresh: " ,tokenResponse)
        UserSingleton.shared.loggedInUser?.tokenResponse = tokenResponse
        return tokenResponse
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
