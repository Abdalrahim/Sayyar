//
//  TextNetworkManager.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 04/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import Firebase
import SwiftUI

class TextNetworkManager : ObservableObject {
    
    let room : String
    
    @Published var messages:[TextMessage] = [TextMessage]()
    
    func getAllCourses() {
        let db = Firestore.firestore()
        
        db.collection("messages").document(room).addSnapshotListener({ (querySnapshot, error) in
            if let error = error  {
                print("Error getting documents: \(error.localizedDescription)")
                return
            }
            
            guard let data = querySnapshot?.data() else {
                print("no message")
                return
            }
                
            if let textdataArr = data["messages"] as? [[String : Any]] {
                var textArr : [TextMessage] = []
                for txt in textdataArr {
                    let text = TextMessage(doc: txt)
                    textArr.append(text)
                }
                self.messages = textArr
            } else {
                print("no messages in message")
            }
            
        })
    }
    
    init(room : String) {
        self.room = room
        getAllCourses()
    }
}
