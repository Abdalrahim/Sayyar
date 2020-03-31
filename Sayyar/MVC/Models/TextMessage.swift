//
//  TextMessage.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 04/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Firebase

class TextMessage: Identifiable {
    
    var text : String
    var time : Timestamp
    var senderId : String
    
    init(doc: [String : Any]) {
        self.text = doc["text"] as! String
        self.time = doc["time"] as! Timestamp
        self.senderId = doc["senderId"] as! String
    }
}
