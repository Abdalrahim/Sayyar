//
//  APIHandler.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 07/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import ObjectMapper
import SwiftyJSON

extension RegisterEndPoint {
  
  func handle(data : Any) -> AnyObject? {
    
    switch self {
    case .login(_) :
        let tokenResponse = Mapper<TokenResponse>().map(JSONObject: data)
        TokenSingleton.shared.currentToken = tokenResponse
        return tokenResponse
    case .refresh:
        let tokenResponse  = Mapper<TokenResponse>().map(JSONObject: data)
        TokenSingleton.shared.currentToken = tokenResponse
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
