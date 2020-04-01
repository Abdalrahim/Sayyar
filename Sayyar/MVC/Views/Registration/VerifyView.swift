//
//  VerifyView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 23/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct VerifyView: View {
    
    @State var phone : String = "050 000 0000"
    @State var num1 : String = ""
    @State var num2 : String = ""
    @State var num3 : String = ""
    @State var num4 : String = ""
    
    @State var seconds : Int = 60
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            
            Text("Insert the code that is sent to \(self.phone)")
                .font(.custom("Cairo-Regular", size: 18))
                .lineLimit(2)
            
            HStack(spacing : 15) {
                verifytf(placename: self.$num1.animation(.default)) {
                    
                }
                .frame(width : 50)
                
                verifytf(placename: self.$num2) {
                    
                }
                .frame(width : 50)
                
                verifytf(placename: self.$num3) {
                    
                }
                .frame(width : 50)
                
                verifytf(placename: self.$num4) {
                    
                }
                .frame(width : 50)
                
            }.font(.custom("Cairo-SemiBold", size: 20))
            
            Spacer()
            HStack {
                Button(action: {
                    
                }) {
                    HStack(alignment: .center) {
                        Text("resend")
                            .font(.custom("Cairo-SemiBold", size: 15))
                            .foregroundColor(Color.gray)
                    }
                }
                Spacer()
                
                HStack {
                    Text("\(seconds) sec")
                    Image(systemName: "clock.fill")
                }.foregroundColor(purple)
            }
            Spacer()
            
            HStack(alignment: .center, spacing: 10) {
                // MARK: Add Pin
                Button(action: {
                    
                }) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("sign.in")
                            .font(.custom("Cairo-SemiBold", size: 20))
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }
                .frame(height: 22, alignment: .center)
                .padding()
                .background(
                    RadialGradient(gradient:
                        Gradient(
                            colors: [Color(#colorLiteral(red: 0.7254901961, green: 0.1647058824, blue: 0.4745098039, alpha: 1)), Color(#colorLiteral(red: 0.3450980392, green: 0.2039215686, blue: 0.4470588235, alpha: 1))]),
                                   center: .leading,
                                   startRadius: 5,
                                   endRadius: 400
                    )
                        .scaleEffect(1.5))
                    .cornerRadius(10)
            }.padding(.horizontal, 30)
            
            Spacer()
        }.padding(.horizontal)
        .onReceive(timer) { input in
            withAnimation {
                if (self.seconds > 0) {
                    self.seconds -= 1
                }
            }
        }
    }
}

struct VerifyView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyView()
    }
}

struct verifytf: View {
    
    @State var textFieldActive : Bool = false
    @Binding var placename : String
    
    var commit: () -> ()
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            
            
            TextField("", text: $placename, onEditingChanged: {edited in
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
        }
    }
}
