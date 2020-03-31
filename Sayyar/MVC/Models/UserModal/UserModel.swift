//
//  UserModel.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 09/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel :  Mappable{
    
    var userDetail : UserDetail?
    var message : String?
    
    var statusCode: Int?
    var userData :  UserData?
    var currency : [String]?
    var appVersion:DeviceTypeVersion?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        userDetail <- map["result"]
        message <- map["msg"]

        statusCode <- map["statusCode"]
        appVersion <- map["result.versioning"]
        userData <- map["result.user"]
        currency <- map["result.currencies"]
    }
}

class UserDetail : NSObject , Mappable {
    
    var Versioning : AppVersion?
    var step : String?
    var otp : Int?
    var userData : UserData?
   

    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        Versioning <- map["Versioning"]
        step <- map["step"]
        otp <- map["otp"]
        userData <- map["user"]
    }
}

class UserData : Mappable{
    
    var userId : String?
//    var userDeviceDetail : UserDevice?

    var email : String?
    var password : String?

    
    var firstName : String?
    var lastName : String?
    var userName : String?

    var phoneNumber : String?
    var phoneCode : String?
    
    var profilePic : String?
    var profilePicThumb : String?
    
//    var settings: UserSettings?

    
    required init?(map: Map){}
    
    init(uid: String?, firstName : String , lastName : String , email: String? , key : String? , imageUrl: String?) {
        self.userId = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        
        self.profilePic = imageUrl
        self.profilePicThumb = imageUrl
    }
    
    
    func mapping(map: Map) {
        
        userId <- map["userId"]
        
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        
        email <- map["email"]

        
        phoneNumber <- map["phoneNumber"]
        phoneCode <- map["phoneCode"]
        
    
    }
    
}

class DeviceTypeVersion: NSObject , Mappable {
    
    var force : Int?
    var normal : Int?
    var iosVersion:Double?
    var iosForceVersion:Double?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        force <- map["force"]
        normal <- map["normal"]
        iosVersion <- map["iosVersion"]
        iosForceVersion <- map["iosForceVersion"]
    }
}

class AppVersion: NSObject , Mappable {
    
    var andriod : DeviceTypeVersion?
    var ios : DeviceTypeVersion?
    
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        andriod <- map["ANDROID"]
        ios <- map["IOS"]
        
    }
}
