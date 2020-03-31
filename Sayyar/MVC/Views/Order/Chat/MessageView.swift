//
//  MessageView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 04/02/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import Firebase

struct MessageView: View {
    
    var text : TextMessage
    
    func getSize(text : String) -> CGRect {
        let size = CGSize(width: 350,height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes:[NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], context: nil)
        return estimatedFrame
    }
    
    var body: some View {
        
        VStack(alignment: self.align().0, spacing: 0) {
            HStack() {
                if self.align().2 {
                    Spacer()
                }
                
                ZStack() {
                    
                    RoundedRectangle(cornerRadius: 5, style: .continuous).frame(width: self.getSize(text: self.text.text).width + 60, height: self.getSize(text: self.text.text).height + 40)
                        .foregroundColor( self.align().1)
                        .cornerRadius(12)
                    
                    Text("\(text.text)")
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                }.padding(.all , 5)
                
                if !self.align().2 {
                    Spacer()
                }
            }
            
            Text(getDate(format: "hh:mm a", date: text.time.dateValue()))
                .fontWeight(.light).padding(.leading, 15)
        }
    }
    
    func align() -> (HorizontalAlignment, Color, Bool) {
        if let id = Auth.auth().currentUser?.uid,
            self.text.senderId  == id {
            return (.trailing, Color(#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)), true)
        } else {
            return (.leading, Color(#colorLiteral(red: 0.5777706504, green: 0.4558702111, blue: 1, alpha: 1)), false)
        }
    }
    
    func getDate(format: String, date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
}


let demoTextDoc : [String: Any] = [
    "text" : "Hello my name is sam and I ",
    "time" : Timestamp(date: Date()),
    "senderId" : "Me"
]

 let textUno = TextMessage(doc: demoTextDoc)

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(text: textUno)
    }
}
