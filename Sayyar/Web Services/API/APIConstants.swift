//
//  APIConstants.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 06/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Foundation

enum ApplicationPhase {
    
    case live
    case dev
}

let application_phase : ApplicationPhase = .dev

internal struct APIBasePath {
    
    //Server
    static var basePath :String {
        
        get {
            
            if application_phase == .dev {
                
                 return  "https://api-dev.syyar.net/api/"
                
            } else {
                
                return "https://api-dev.syyar.net/api/"
                
            }
        }
    }
}

internal struct APITypes {
    
    static let register = "/register"
    
    static let refresh = "/refresh"
}

enum Response {
    
    case success(Any?)
    case failure(String?)
}

typealias OptionalDictionary = [String : Any]?

enum Keys : String {
    
    case email = "email"
    
    case firstName = "first_name"
    
    case lastName = "last_name"
    
    case password = "password"
    
    case passwordConfirmation = "password_confirmation"
    
    case nationalID = "national_id"
    
    case bank_acc_no = "bank_acc_no"
    
    case mobile = "mobile"
    
    case age = "age"
    
    case clientType = "client_type"
    
    case displayName = "display_name"
    
    case code = "code"
    
    case accessToken = "access_token"
}

enum Validate : String {
    
    case none
    case success = "1"
    case failure = "0"
    case invalidAccessToken = "-3"
    case fbLogin = "3"
    
    func map(response message : String?) -> String? {
        
        switch self {
            
        case .success:
            return message
            
        case .failure :
            return message
            
        case .invalidAccessToken :
            return message
            
        default:
            return nil
        }
    }
}

struct Parameters {
    
    /// Mark: Register
    static let register : [Keys] = [.email, .firstName, .lastName, .mobile, .clientType]
    
    static let refresh : [Keys] = [.accessToken]
}

internal struct Routes {
    
    static let auth = "auth"
    static let drivers = "drivers"
    
}

enum APIConstants:String {
    
    case success = "success"
    case message = "message"
    case accessToken = "access_token"
    case tokenExpire = "expires_in"
    
}
