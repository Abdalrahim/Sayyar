//
//  SMSEndPoint.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 13/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Alamofire

enum SMSEndPoint {
    
    case loginSms(phone : String?, isLogin: Bool)
    case registerSms(phone : String?)
}

extension SMSEndPoint: Router {
    
    var baseURL: String {
        switch self{
        default:
            return APIBasePath.basePath
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
            
        default:
            return APITypes.sms
        }
    }
    
    func format() -> OptionalDictionary {
        switch self {
        case .loginSms(phone: let phone, isLogin: let login):
            return Parameters.phone.map(values: [phone, "\(login)"])
        case .registerSms(phone: let phone):
            return Parameters.registerSms.map(values: [phone])
        }
    }
    
    
    func request(completion: @escaping Completion) {
        APIManager.init().request(with: self, completion: completion)
    }
    
    
    var header: [String : String] {
        let accessToken = UserSingleton.shared.loggedInUser?.tokenResponse?.accessToken ?? ""
        
        return ["Authorization" : "Bearer \(accessToken)"]
    }
    
}
