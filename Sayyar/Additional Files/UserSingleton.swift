
//
//  UserSingleton.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 09/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//


import ObjectMapper

enum SingletonKeys : String {
  
  case user = "UserAccount"
  case isFirstLauch = "isFirstLauch"
  case isGuestLogin = "isGuestLogin"
  case notificationCount =  "notificationCount"
    
}


//MARK: - User Singleton
class UserSingleton:NSObject{
    
    static let shared = UserSingleton()
    
    var loggedInUser : UserModel? {
        
        get{
            
            guard let data = UserDefaults.standard.value(forKey: SingletonKeys.user.rawValue) else{
                
                let mappedModel = Mapper<UserModel>().map(JSON: [:] )
                return mappedModel
            }
            
            let mappedModel = Mapper<UserModel>().map(JSON: data as! [String : Any])
            return mappedModel
            
        }set{
            
            if let value = newValue {
                UserDefaults.standard.set(value.toJSON(), forKey: SingletonKeys.user.rawValue)
                UserDefaults.standard.synchronize()
                
            } else {
                UserDefaults.standard.removeObject(forKey: SingletonKeys.user.rawValue)
            }
        }
    }
    
   static var notificationCount : String? {
        
        get {
            
            return UserDefaults.standard.string(forKey: SingletonKeys.notificationCount.rawValue)   //value(forKey: SingletonKeys.notificationCount.rawValue)
            
        } set {
            
            if let value = newValue {
                
                UserDefaults.standard.set(value, forKey: SingletonKeys.notificationCount.rawValue)
                UserDefaults.standard.synchronize()

            } else {
                UserDefaults.standard.removeObject(forKey:SingletonKeys.notificationCount.rawValue)
            }
        
        }
        
    }
}
