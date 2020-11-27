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
    // MARK: Corner Radius
    @State var cR : CGFloat = 12
    @State var alig = true
    
    func getSize(text : String) -> CGRect {
        let size = CGSize(width: 350,height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes:[NSAttributedString.Key.font : UIFont.init(name: "Cairo-Regular", size: 20)!], context: nil)
        return estimatedFrame
    }
    
    var body: some View {
        
        HStack() {
            if self.align().isUser {
                Spacer()
            }
            
            ZStack {
                RoundedCorners(color: self.align().color, tl: cR, tr: cR, bl: self.align().isUser ? cR : 0, br: self.align().isUser ? 0 : cR)
                    .frame(
                        width: self.getSize(text: self.text.text).width + 60,
                        height: self.getSize(text:  self.text.text).height + 20
                )
                
                VStack(alignment: self.align().align, spacing : 0) {
                    Text("\(text.text)")
                        .font(.custom("Cairo-SemiBold", size: 18))
                        .foregroundColor(Color(#colorLiteral(red: 0.231372549, green: 0.2745098039, blue: 0.3411764706, alpha: 1)))
                        .frame(
                            width: self.getSize(text: self.text.text).width + 30,
                            height: self.getSize(text: self.text.text).height
                    )
                    
                    HStack {
                        if self.align().isUser {
                            Spacer()
                            Text(getDate(format: "hh:mm a", date: text.time.dateValue()))
                                .foregroundColor(Color(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)))
                                .font(.custom("Cairo-Regular", size: 10))
                        } else {
                            Text(getDate(format: "hh:mm a", date: text.time.dateValue()))
                                .foregroundColor(Color(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)))
                                .font(.custom("Cairo-Regular", size: 10))
                            Spacer()
                            Image("sent")
                        }
                    }
                }.frame(
                    width: self.getSize(text: self.text.text).width + 30
                )
                
            }.padding()
            
            if !self.align().isUser {
                Spacer()
            }
            
        }
    }
    
    func align() -> (align : HorizontalAlignment,color: Color, isUser: Bool) {
        if let id = Auth.auth().currentUser?.uid,
            self.text.senderId  == id {
            return (.trailing, Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)), true)
        } else {
            return (.leading, Color(#colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)), false)
        }
    }
    
    
}

func getDate(format: String, date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    dateFormatter.dateFormat = format
    dateFormatter.locale = Locale(identifier: "en_GB")
    return dateFormatter.string(from: date)
}


let demoTextDoc : [String: Any] = [
    "text" : "Hello my name is sam and I like cold show",
    "time" : Timestamp(date: Date()),
    "senderId" : "Me"
]

 let textUno = TextMessage(doc: demoTextDoc)

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(text: textUno)
    }
}
