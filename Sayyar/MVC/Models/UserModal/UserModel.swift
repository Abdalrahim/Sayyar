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
    var userDeviceDetail : UserDevice?

    var email : String?
    var emailVerified : String?
    var password : String?

    
    var firstName : String?
    var lastName : String?
    var userName : String?

    var mobile : String?
    
    var profilePic : String?
    var clientType : String?
    var status : String?
    var proposals : NSArray?
    var city : String?
    
//    var settings: UserSettings?

    
    required init?(map: Map){}
    
    init(uid: String?, firstName : String , lastName : String , email: String? , key : String? , imageUrl: String?) {
        self.userId = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        
        self.profilePic = imageUrl
    }
    
    
    func mapping(map: Map) {
        
        userId <- map["id"]
        
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        email <- map["email"]

        
        mobile <- map["mobile"]
        proposals <- map["proposals"]
    
    }
    
}

class UserDevice : NSObject , Mappable {
    
    var updatedAt : String?
    var userDevicesId : Int?
    var accessToken : String?
    
    var socketId : String?
    var fcmId : String?
    
    var longitude : Int?
    var deviceId : String?
    var deviceType : String?
    
    var latitude : Int?
    var userId : Int?
    
    var language : String?
    var timezone : String?
    var createdAt : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        updatedAt <- map["updatedAt"]
        userDevicesId <- map["userDevicesId"]
        accessToken <- map["accessToken"]
        
        socketId <- map["socketId"]
        fcmId <- map["fcmId"]
        
        longitude <- map["longitude"]
        deviceId <- map["deviceId"]
        deviceType <- map["deviceType"]
        
        latitude <- map["latitude"]
        userId <- map["userId"]
        
        language <- map["language"]
        timezone <- map["timezone"]
        createdAt <- map["createdAt"]
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
