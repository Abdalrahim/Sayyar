//
//  VerifyView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 23/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import Introspect

struct VerifyView: View {
    
    @ObservedObject var apimanager: APIManager = APIManager()
    
    @State var phone : String
    @State var pin: String = "".replacedArabicDigitsWithEnglish
    
    @State var seconds : Int = 60
    
    @State var resendShow : Bool = false
    
    @Binding var showSmsVerify : Bool
    
    @State var showResend : Bool = false
    
    @Binding var showSignIn : Bool
    
    @State var login : Bool
    
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
    }
    
    private func smslogin() {
        self.apimanager.request(with: RegisterEndPoint.login(phone: self.phone, code: self.pin)) { (response) in
            switch response {
            case .success(let data):
                print("data",data)
                self.showSignIn.toggle()
                break
            case .failure(let fail):
                debugPrint("SMSEndPoint", fail as Any)
            }
        }
    }
    
    private func resendSms() {
        self.apimanager.request(with:
            SMSEndPoint.sendSmsto(phone: self.phone, isLogin: self.login)
        ) { (response) in
            switch response {
            case .success(_):
                self.seconds = 60
                break
            case .failure(let fail):
                debugPrint("SMSEndPoint", fail as Any)
            }
        }
    }
}

struct VerifyView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyView(phone: "050 000 000", showSmsVerify: .constant(true), showSignIn: .constant(true), login: true)
    }
}

public struct PasscodeField: View {
    
    var maxDigits: Int = 4
    
    @State var pin: String = ""
    
    
    var handler: (String, (Bool) -> Void) -> Void
    
    public var body: some View {
        VStack(spacing: 20) {
            ZStack(alignment: .leading) {
                pinDots
                backgroundField
            }
        }
        
    }
    
    private var pinDots: some View {
        HStack(spacing : 0) {
            Spacer()
            ForEach(0..<maxDigits) { index in
                ZStack {
                    if index >= self.pin.count {
                        RoundedRectangle(cornerRadius: 5)
                        .stroke(index >= self.pin.count ? Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)) : purple, lineWidth: 1)
                        .frame(width: 44, height: 44)
                    } else {
                        RoundedRectangle(cornerRadius: 5)
                        .stroke(index >= self.pin.count ? Color(#colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)) : purple, lineWidth: 1)
                        .frame(width: 44, height: 44)
                        Text(self.pin.digits[index].numberString)
                        .font(.custom("Cairo-SemiBold", size: 18))
                    }
                }
                Spacer()
            }
        }
    }
    
    
    private var pintxt: some View {
        HStack(spacing : 0) {
            ForEach(0..<pin.count) { index in
                Text(self.pin.digits[index].numberString)
                    .padding(.leading, UIScreen.main.bounds.width/6.5)
            }
        }
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            self.submitPin()
        })
        
        return TextField("", text: boundPin, onCommit: submitPin)
//           .accentColor(.clear)
//           .foregroundColor(.clear)
//           .keyboardType(.numberPad)
      
             .introspectTextField { textField in
                 textField.tintColor = .clear
                 textField.textColor = .clear
                 textField.keyboardType = .numberPad
                 textField.becomeFirstResponder()
                 textField.isHidden = true
         }
    }
    
    private func submitPin() {
        guard !pin.isEmpty else {
            return
        }
        
        if pin.count == maxDigits {
            
            handler(pin) { isSuccess in
                if isSuccess {
                    print("pin matched, go to next page, no action to perfrom here")
                } else {
                    pin = ""
                    print("this has to called after showing toast why is the failure")
                }
            }
        }
        
        // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
        // max digits, we remove the additional characters and make a recursive call.
        if pin.count > maxDigits {
            pin = String(pin.prefix(maxDigits))
            submitPin()
        }
    }
}


