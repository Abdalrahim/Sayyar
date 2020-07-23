//
//  GeneralEndPoint.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 22/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Alamofire

enum GeneralEndPoint {
    
    case contactUs(reason : Int?, subject: String?, description: String?)
    case purpose
}

extension GeneralEndPoint: Router {
    
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
        case .purpose:
            return .get
        default:
            return .post
        }
    }
    
    var route: String  {
        
        switch self {
            
        case .contactUs:
            return APITypes.contactus
        case .purpose:
            return APITypes.contactpurpose
        }
    }
    
    func format() -> OptionalDictionary {
        switch self {
        case .contactUs(let reason, let subject, let description):
            return Parameters.contactus.map(values: [reason, subject, description])
        case .purpose:
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
