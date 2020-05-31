//
//  RegisterView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 19/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    
    @State var firstName : String = "Majid"
    @State var lastName : String = "AlSaqer"
    @State var phoneNumber : String = "0539128374"
    @State var email : String = "majed@gmail.com"
    
    @State var notRegister : Bool = false
    @State var checked : Bool = true
    
    @State var firstnameCheck : Bool = true
    @State var lastnameCheck : Bool = true
    @State var phoneCheck : Bool = true
    @State var emailCheck : Bool = true
    
    var body: some View {
        VStack {
            Image("registerImage")
                .resizable()
                .padding(.trailing, -100.0)
                .padding(.bottom, -80)
            VStack {
                VStack {
                    Text("Create an Account")
                        .foregroundColor(gray)
                        .font(.custom("Cairo-Black", size: 15))
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 20) {
                            VStack(spacing: 15) {
                                HStack(spacing: 15) {
                                    customTextField(placeholder: "first.name", placename: self.$firstName, fieldReq: self.$firstnameCheck) {
                                        
                                    }
                                    .font(.custom("Cairo-SemiBold", size: 15))
                                    
                                    customTextField(placeholder: "last.name", placename: self.$lastName, fieldReq: self.$lastnameCheck) {
                                        
                                    }
                                    .font(.custom("Cairo-SemiBold", size: 15))
                                }
                                HStack(spacing: 15) {
                                    VStack(spacing: 0) {
                                        HStack(spacing: 5) {
                                            Image(systemName: "arrowtriangle.down.fill")
                                                .resizable()
                                                .frame(width: 13, height: 7)
                                            
                                            Text("966")
                                                .font(.custom("Cairo-SemiBold", size: 15))
                                            
                                            
                                            Image("sa-flag")
                                        }.padding(.vertical, 7)
                                        
                                    }.frame(width: 90)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(purple , lineWidth: 1)
                                    )
                                    
                                    customTextField(placeholder: "phone", placename: self.$lastName, fieldReq: self.$phoneCheck) {
                                        
                                    }
                                    .font(.custom("Cairo-SemiBold", size: 15))
                                }
                                customTextField(placeholder: "email", placename: self.$firstName, fieldReq: self.$emailCheck) {
                                    
                                }
                            }
                            
                        }
                        VStack(spacing: 0){
                            if self.notRegister {
                                HStack {
                                    Image(systemName : "exclamationmark.circle.fill")
                                        .foregroundColor(red)
                                    
                                    
                                    Text("phone number not registered")
                                        .font(.custom("Cairo-Regular", size: 15))
                                        .foregroundColor(red)
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
                        HStack {
                            if self.checked {
                                Image(systemName : "checkmark.square.fill")
                                    .foregroundColor(purple)
                            } else {
                                Image(systemName : "square")
                                    .foregroundColor(purple)
                            }
                            
                            
                            
                            Text("I accept ")
                                .font(.custom("Cairo-Regular", size: 15))
                                + Text("Terms of use")
                                    .font(.custom("Cairo-Regular", size: 15))
                                    .foregroundColor(purple).underline()
                                + Text(" & ")
                                    .font(.custom("Cairo-Regular", size: 15))
                                + Text("Privacy Policy")
                                    .font(.custom("Cairo-Regular", size: 15))
                                    .foregroundColor(purple).underline()
                        }.onTapGesture {
                            withAnimation {
                                self.checked.toggle()
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
                    }.padding()
                    
                    Text("Go to Sign In Page")
                        .foregroundColor(purple)
                        .font(.custom("Cairo-SemiBold", size: 13))
                        .underline()
                    
                    
                    
                }
                .padding()
                
            }.background(RoundedCorners(color: bgColor, tl: 60, tr: 60, bl: 0, br: 0))
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
