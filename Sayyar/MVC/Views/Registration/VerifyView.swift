//
//  VerifyView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 23/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import Introspect
import SwiftyJSON

struct VerifyView: View {
    
    @ObservedObject var apimanager: APIManager = APIManager()
    
    @State var phone : String
    @State var pin: String = "".replacedArabicDigitsWithEnglish
    
    @State var seconds : Int = 60
    
    @State var resendShow : Bool = false
    
    @Binding var showSmsVerify : Bool
    
    @State var showResend : Bool = false
    
    @Binding var showSignIn : Bool
    
    @State var isForLogin : Bool
    
    @State var alertTitle : String = ""
    @State var showAlert : Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Image(systemName: L102Language.isRTL ? "arrow.right" : "arrow.left")
                    .imageScale(.large)
                    .onTapGesture {
                        self.showSmsVerify.toggle()
                }
                Spacer()
            }.foregroundColor(dark)
            Spacer()
            
            HStack {
                Text("insert.code")
                    + Text(" \(self.phone)")
            }
            .font(.custom("Cairo-Regular", size: 18))
            .lineLimit(2)
            
            PasscodeField { (text, boolean ) in
                self.pin = text
                self.smslogin()
                print(text )
            }
            
            Spacer()
            
            HStack {
                if self.resendShow {
                    Button(action: {
                        self.resendSms()
                    }) {
                        HStack(alignment: .center) {
                            Text("resend")
                                .font(.custom("Cairo-SemiBold", size: 15))
                                .foregroundColor(Color.gray)
                            
                        }
                    }.disabled(self.showResend)
                }
                Spacer()
                
                
                HStack {
                    Text(String.localizedStringWithFormat("sec".localizewithnumber(count: UInt(seconds))))
                        .scaledToFill()
                        .layoutPriority(0)
                        .font(.custom("Cairo-Regular", size: 18))
                        .padding()
                    Image(systemName: "clock.fill")
                }
                .foregroundColor(purple)
            }
            Spacer()
            
            HStack(alignment: .center, spacing: 10) {
                Button(action: {
                    self.smslogin()
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
                    if self.seconds == 0 {
                        self.resendShow = true
                    } else {
                        self.resendShow = false
                    }
                }
        }
        .navigationBarHidden(true)
        .alert(isPresented: self.$showAlert, content: {
            Alert(title: Text("Error"), message: Text(self.alertTitle), dismissButton: .default(Text("Ok")))
        })
    }
    
    private func smslogin() {
        self.apimanager.request(with: AuthEndPoint.login(phone: self.phone, code: self.pin)) { (response) in
            switch response {
            case .success(let data):
                guard let token = data as? TokenResponse else {
                    self.alertWith(message: JSON(data ?? "No Token Data").stringValue)
                    return
                }
                
                self.showSignIn.toggle()
                
                break
            case .failure(let fail):
                self.alertWith(message: fail ?? "")
                debugPrint("SMSEndPoint.RegisterEndPoint", fail as Any)
            }
        }
    }
    
    private func resendSms() {
        self.apimanager.request(with:
            isForLogin ? SMSEndPoint.loginSms(phone: self.phone, isLogin: self.isForLogin) : SMSEndPoint.registerSms(phone: self.phone)
        ) { (response) in
            switch response {
            case .success(_):
                self.seconds = 60
                break
            case .failure(let fail):
                self.alertWith(message: fail ?? "")
                debugPrint(self.isForLogin ? "SMSEndPoint.loginSms" : "SMSEndPoint.registerSms", fail as Any)
            }
        }
    }
    
    private func alertWith(message: String) {
        self.alertTitle = message
        self.showAlert.toggle()
    }
}

struct VerifyView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyView(phone: "050 000 000", showSmsVerify: .constant(true), showSignIn: .constant(true), isForLogin: true)
    }
}



