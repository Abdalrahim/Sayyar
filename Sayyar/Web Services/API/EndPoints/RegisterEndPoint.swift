//
//  RegisterEndPoint.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 06/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Alamofire

enum RegisterEndPoint {
    
    case register(email : String?, firstName: String?, lastName: String?, phone: String?, clientType : String?)
    case refresh(accessToken : String?)
    case login(phone : String?, code: String?)
}

extension RegisterEndPoint: Router {
    
    var baseURL: String {
        switch self{
        default:
             return APIBasePath.basePath + Routes.auth
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
            
        case .register(_):
            return APITypes.register
            
        case .refresh(_):
            return APITypes.refresh
            
        case .login(_):
            return APITypes.login
        }
    }
    
    func format() -> OptionalDictionary {
        switch self {
            
        case .register(let email,let firstName,let lastname, let phone, let clientType):
            return Parameters.register.map(values: [email, firstName, lastname, phone, clientType])
        case .refresh(let accessToken):
            return Parameters.refresh.map(values: [accessToken])
        case .login(phone: let phone, code: let code):
            return Parameters.login.map(values: [phone, code])
        }
    }
    
    
    func request(completion: @escaping Completion) {
        APIManager.init().request(with: self, completion: completion)
    }
    
    
    var header: [String : String] {
        let accessToken = UserSingleton.shared.loggedInUser?.accessToken ?? ""
        
        return ["Authorization" : "Bearer \(accessToken)"]
    }
    
}
