//
//  TextNetworkManager.swift
//  TeraTaxi SwiftUI
//
//  Created by Abdalrahim Abdullah on 18/11/2019.
//  Copyright © 2019 Teracit. All rights reserved.
//

import Firebase

class TextNetworkManager : ObservableObject {
    
    @Published var messages:[TextMessage] = [TextMessage]()
    
    var room : String
    
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
