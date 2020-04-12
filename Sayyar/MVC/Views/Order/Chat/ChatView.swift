//
//  ChatView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 04/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import Firebase

// Chat View
struct ChatView: View {
    
    let db = Firestore.firestore()
    
    @ObservedObject var room: TextNetworkManager
    
    @State var messages:[TextMessage] = [
        TextMessage(doc: [
            "text" : "Hello my name is sam and I like cold show",
            "time" : Timestamp(date: Date()),
            "senderId" : "Me"
        ])
        ,
        TextMessage(doc: [
            "text" : "Hello my name is sam and I like cold show",
            "time" : Timestamp(date: Date()),
            "senderId" : "Me"
        ])
        ,
        TextMessage(doc: [
            "text" : "Hello my name is sam",
            "time" : Timestamp(date: Date()),
            "senderId" : "sa"
        ])
    ]
    
    @State var tfMessage = ""
    
    var body: some View {
        
        VStack(spacing: 8) {
            ReverseScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(self.messages) { message in
                        return MessageView(text: message)
                    }
                }
            }
            
            TextField("write something..", text: self.$tfMessage, onEditingChanged: { (edited) in
                
                if self.tfMessage.isEmpty { return }
                
                self.sendMessage()
                
                self.tfMessage = ""
            }) {
                print(self.tfMessage)
            }
        }.padding()
    }
    
    func sendMessage() {
        let messageRef = self.db.collection("messages").document("Terataxi Dev Room")
        guard let user = UserSingleton.shared.loggedInUser?.userData?.userId else { return }
        let messageData : [String : Any] = [
            "text" : self.tfMessage,
            "time": Timestamp(date: Date()),
            "senderId": user
        ]
        
        // For some reason these crash the preview
//        messageRef.updateData(
//            [
//                "messages": FieldValue.arrayUnion([messageData])
//            ]
//        )
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(room: TextNetworkManager(room: "Terataxi Dev Room"))
    }
}

