//
//  SignInView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 15/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import Combine

struct SignInView: View {
    
    @State var phoneNum : String = ""
    
    @State var notRegister : Bool = false
    
    var body: some View {
        VStack {
            Image("registerImage")
                .resizable()
                .padding(.trailing, -100.0)
                .padding(.bottom, -80)
            VStack {
                GeometryReader { geometry in
                    VStack {
                        Text("Ready To Start Your Trip with us?")
                            .foregroundColor(purple)
                            .font(.custom("Cairo-Black", size: 15))
                            .padding(.top)
                        
                        VStack(alignment: .leading) {
                            HStack(spacing: 20) {
                                VStack(spacing: 5) {
                                    HStack(spacing: 5) {
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .resizable()
                                            .frame(width: 16, height: 7)
                                        
                                        Text("966")
                                            .font(.custom("Cairo-SemiBold", size: 15))
                                        
                                         
                                        Image("sa-flag")
                                    }
                                    Divider()
                                }.frame(width: 80)
                                
                                VStack(spacing: 5) {
                                    TextField("phone", text: self.$phoneNum)
                                        .font(.custom("Cairo-SemiBold", size: 15))
                                    Divider()
                                        .background(self.notRegister ? red : Color.clear)
                                    
                                }
                                
                            }
                            if self.notRegister {
                                HStack {
                                    Image(systemName : "exclamationmark.circle.fill")
                                        .foregroundColor(red)
                                    
                                    
                                    Text("phone number not registered")
                                        .font(.custom("Cairo-Regular", size: 15))
                                        .foregroundColor(red)
                                }
                            }
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
                                        .alignmentGuide(.lastTextBaseline, computeValue: { d in
                                            d[.bottom] * 0.927
                                        }
                                    )
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
                        }
                        Spacer()
                        Text("Dont have an account? ")
                            .font(.custom("Cairo-SemiBold", size: 15))
                            +
                            Text("Create an account!")
                                .foregroundColor(purple)
                                .font(.custom("Cairo-SemiBold", size: 15))
                        
                        Spacer()
                        
                    }
                    .padding()
                    .frame(height: geometry.size.height)
                    
                }
            }
            .background(RoundedCorners(color: bgColor, tl: 60, tr: 60, bl: 0, br: 0))
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
