//
//  UserModel.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 09/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Foundation
import ObjectMapper


class UserData : NSObject, Mappable{
    var userId : String?

    var email : String?
    var emailVerifiedAt : String?
    
    var firstName : String?
    var lastName : String?
    var userName : String?
    var mobile : String?
    var age : Int?
    var nationalId : String?
    
    var profilePic : String?
    var clientType : String?
    var status : String?
    var proposals : [Proposals]?
    var city : String?
    var car : Car?
    
    var media : [String]?
    
    required init?(map: Map){}
    
    init(uid: String?, firstName : String? , lastName : String?, email: String? , imageUrl: String?, token: TokenResponse?) {
        self.userId = uid
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        
        self.profilePic = imageUrl
    }
    
    
    func mapping(map: Map) {
        print("User Data Mapping",map.JSON)
        userId <- map["id"]
        
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        email <- map["email"]

        
        mobile <- map["mobile"]
        proposals <- map["proposals"]
    
    }
    
}

class TokenResponse: NSObject , Mappable {
    var accessToken : String?
    var token_type : String?
    var expires_in : Int?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        print("TokenResponse Mapping",map.JSON)
        accessToken <- map["access_token"]
        token_type <- map["token_type"]
        expires_in <- map["expires_in"]
    }
}

class Car: NSObject , Mappable {
    
    var id : Int?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        id <- map["id"]
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

class Proposals : NSObject , Mappable {
    
    var id : Int?
    var orderId : Int?
    var driverId : Int?
    var estimatedPickup : String?
    var estimatedArrival : String?
    var cost : String?
    var status : String?
    var createdAt : String?
    var updatedAt : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        id <- map["id"]
        orderId <- map["order_id"]
        driverId <- map["driver_id"]
        estimatedPickup <- map["estimated_pickup"]
        estimatedArrival <- map["estimated_arrival"]
        cost <- map["cost"]
        status <- map["status"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
    }
}
