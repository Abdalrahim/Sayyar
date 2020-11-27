//
//  ReasonData.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 22/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import ObjectMapper
import SwiftyJSON

class ReasonData: NSObject , Mappable {
    var id : Int?
    var name_ar : String?
    var name_en : String?
    
    required init?(map: Map){}
    
    init(json: JSON) {
        id = json["id"].int
        name_ar = json["name_ar"].string
        name_en = json["name_en"].string
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        name_ar <- map["name_ar"]
        name_en <- map["name_en"]
        print("ReasonData Mapping",map.JSON, id, name_ar, name_en)
    }
    
    func withJson(json: JSON) {
        id = json["id"].int
        name_ar = json["name_ar"].string
        name_en = json["name_en"].string
    }
}
