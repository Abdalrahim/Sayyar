//
//  customTextField.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 22/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct customTextField: View {
    
    @State var placeholder : String
    
    @State var textFieldActive : Bool = false
    
    @Binding var placename : String
    
    @Binding var fieldReq : Bool
    
    var commit: () -> ()
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            
            TextField(placeholder, text: $placename, onEditingChanged: {edited in
                withAnimation {
                    self.textFieldActive = edited
                }
            }, onCommit: {
                self.commit()
            }).frame(height: 44).padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(textFieldActive || !placename.isEmpty ? purple : Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)), lineWidth: 1)
            )
            
            if fieldReq {
                Text("Field required")
                .font(.custom("Cairo-Bold", size: 12))
                .foregroundColor(red)
                .padding(2)
                .background(Color.white)
                .padding(.leading)
                .padding(.bottom, 45)
                .transition(.move(edge: .bottom))
                .animation(.easeIn)
            }
            
            if textFieldActive || !placename.isEmpty {
                Text(placeholder)
                    .font(.custom("Cairo-Bold", size: 12))
                    .foregroundColor(purple)
                    .padding(2)
                    .background(Color.white)
                    .padding(.leading)
                    .padding(.bottom, 45)
                    .transition(.move(edge: .bottom))
                    .animation(.easeIn)
                    
            }
        }
    }
}

struct customTextField_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            customTextField(placeholder: "last.name", placename: .constant(""), fieldReq: .constant(true)) {
                
            }.padding()
        }.previewLayout(.fixed(width: 300, height: 70))
        
    }
}
