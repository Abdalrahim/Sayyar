//
//  TokenSingleton.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 20/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import ObjectMapper

class TokenSingleton:NSObject{
    
    static let shared = TokenSingleton()
    
    var currentToken : TokenResponse? {
        
        get{
            
            guard let data = UserDefaults.standard.value(forKey: SingletonKeys.token.rawValue) else{
                
                let mappedModel = Mapper<TokenResponse>().map(JSON: [:] )
                return mappedModel
            }
            
            let mappedModel = Mapper<TokenResponse>().map(JSON: data as! [String : Any])
            return mappedModel
            
        }set{
            
            if let value = newValue {
                UserDefaults.standard.set(value.toJSON(), forKey: SingletonKeys.token.rawValue)
                UserDefaults.standard.synchronize()
                
            } else {
                UserDefaults.standard.removeObject(forKey: SingletonKeys.token.rawValue)
            }
        }
    }
}
