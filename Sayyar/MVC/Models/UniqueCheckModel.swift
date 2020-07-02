//
//  UniqueCheckModel.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 03/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import ObjectMapper

class UniqueCheckModel: NSObject , Mappable{
    
    var data : UniqueCheckData?
    var message : String?
    var statusCode : Int?
    var success : Int?
    
    
    required init(msg : String) {
        message = msg
    }
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        data <- map["data"]
        message <- map["msg"]
        statusCode <- map["statusCode"]
        success <- map["success"]
    }
}


class UniqueCheckData: NSObject , Mappable{
    
    var email : UniqueCheckData?
    var shop : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        
        email <- map["email"]
        shop <- map["shop"]
    }
}
