//
//  ReasonData.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 22/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import ObjectMapper

class ReasonData: NSObject , Mappable {
    var id : Int?
    var name_ar : String?
    var name_en : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map) {
        print("ReasonData Mapping",map.JSON)
        id <- map["id"]
        name_ar <- map["name_ar"]
        name_en <- map["name_en"]
    }
}
