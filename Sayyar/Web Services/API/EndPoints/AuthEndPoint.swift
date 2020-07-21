//
//  RegisterEndPoint.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 06/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Alamofire

enum AuthEndPoint {
    
    case register(email : String?, firstName: String?, lastName: String?, phone: String?, clientType : String?)
    case refresh
    case me
    case login(phone : String?, code: String?)
    case contactUs(reason : String?, subject: String?, description: String?)
}

extension AuthEndPoint: Router {
    
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
            
        case .register:
            return APITypes.register
            
        case .me:
            return APITypes.me
            
        case .refresh:
            return APITypes.refresh
            
        case .login:
            return APITypes.login
            
        case .contactUs:
            return APITypes.contactus
        }
    }
    
    func format() -> OptionalDictionary {
        switch self {
            
        case .register(let email,let firstName,let lastname, let phone, let clientType):
            return Parameters.register.map(values: [email, firstName, lastname, phone, clientType])
        case .login(let phone, let code):
            return Parameters.login.map(values: [phone, code])
        case .contactUs(let reason, let subject, let description):
            return Parameters.contactus.map(values: [reason, subject, description])
        default:
            return OptionalDictionary(nilLiteral: ())
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
