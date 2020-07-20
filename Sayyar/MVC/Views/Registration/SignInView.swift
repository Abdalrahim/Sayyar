//
//  SignInView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 15/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import Combine
import SwiftyJSON

struct SignInView: View {
    
    @ObservedObject var apimanager: APIManager = APIManager()
    
    @State var phoneNum : String = "".replacedArabicDigitsWithEnglish
    
    @State var notRegister : Bool = false
    
    @State var phoneCheck : Bool = false
    
    @Binding var showSignIn : Bool
    
    @State var showSmsCheck : Bool = false
    
    @State var showRegister : Bool = false
    
    @State var alertTitle : String = ""
    
    @State var showAlert : Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Image("registerImage")
                    .resizable()
                    .padding(.trailing, -100.0)
                    .padding(.bottom, -80)
                VStack {
                    GeometryReader { geometry in
                        VStack {
                            Text("ready.for.trip")
                                .foregroundColor(purple)
                                .font(Font.custom("Cairo-Black", size: 15))
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
                                        TextField("insert.phone".localized, text: self.$phoneNum)
                                            .keyboardType(.numberPad)
                                            .font(.custom("Cairo-SemiBold", size: 15))
                                        Divider()
                                            .background(self.notRegister ? red : Color.clear)
                                        
                                        
                                    }
                                    
                                }
                                if self.notRegister || self.phoneCheck {
                                    HStack {
                                        Image(systemName : "exclamationmark.circle.fill")
                                            .foregroundColor(red)
                                        
                                        
                                        Text(self.notRegister ? "not.registered" : "field.req")
                                            .font(.custom("Cairo-Regular", size: 15))
                                            .foregroundColor(red)
                                    }
                                }
                            }
                            
                            Spacer()
                            
                            HStack(alignment: .center, spacing: 10) {
                                // MARK: Add Pin
                                Button(action: {
                                    if self.checkfield() {
                                        self.sendSms()
                                    }
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
                            NavigationLink(destination:
                            RegisterView(showSignIn: self.$showSignIn, showRegister: self.$showRegister),isActive: self.$showRegister) {
                                
                                HStack {
                                    Text("no.account")
                                        +
                                        Text(" ")
                                        +
                                        Text("create.account")
                                            .foregroundColor(purple)
                                    
                                }.font(.custom("Cairo-SemiBold", size: 15))
                            }.foregroundColor(purple)
                            Spacer()
                            
                        }
                        .padding()
                        .frame(height: geometry.size.height)
                        
                    }
                }
                .background(RoundedCorners(color: bgColor, tl: 60, tr: 60, bl: 0, br: 0))
                
                NavigationLink("", destination:
                    VerifyView(phone: self.phoneNum, showSmsVerify: self.$showSmsCheck, showSignIn: self.$showSignIn, isForLogin: true),
                               isActive: self.$showSmsCheck)
            }
            .alert(isPresented: self.$showAlert, content: {
                Alert(title: Text("Error"), message: Text(self.alertTitle), dismissButton: .default(Text("Ok")))
            })
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        }
    }
    
    private func checkfield() -> Bool {
        // TODO: Add more
        self.phoneCheck = self.phoneNum.isEmpty
        return !self.phoneCheck
    }
    
    
    
    private func sendSms() {
        self.apimanager.request(with:
            SMSEndPoint.loginSms(phone: self.phoneNum, isLogin: true)
        ) { (response) in
            switch response {
            case .success(let data):
                if let jsonDict = JSON(data).dictionary {
                    print(jsonDict)
                    
                    if jsonDict["code"] == 200 {
                        self.showSmsCheck = true
                    } else if let message = jsonDict["message"]?.string {
                        self.alertTitle = message
                        self.showAlert.toggle()
                    }
                }
                
                break
            case .failure(let fail):
                debugPrint("SMSEndPoint", fail as Any)
            }
        }
    }
}
//{
//    "success": true,
//    "code": 200,
//    "message": "success",
//    "data": [
//        {
//            "phone_no": "0530003871",
//            "active": true
//        }
//    ]
//}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView( showSignIn: .constant(false))
    }
}
