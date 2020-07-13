//
//  VerifyView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 23/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct VerifyView: View {
    
    @ObservedObject var apimanager: APIManager = APIManager()
    
    @State var phone : String
    @State var pin: String = ""
    
    @State var seconds : Int = 60
    
    @State var resendShow : Bool = false
    
    @Binding var showSmsVerify : Bool
    
    @State var showResend : Bool = false
    
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
                print(text)
            }
            
            Spacer()
            HStack {
                Button(action: {
                    self.apimanager.request(with:
                        SMSEndPoint.sendSmsto(phone: self.phone)
                    ) { (response) in
                        switch response {
                        case .success(_):
                            
                            break
                        case .failure(let fail):
                            debugPrint("SMSEndPoint", fail as Any)
                        }
                    }
                }) {
                    HStack(alignment: .center) {
                        Text("resend")
                            .font(.custom("Cairo-SemiBold", size: 15))
                            .foregroundColor(Color.gray)
                            
                    }
                }.disabled(self.showResend)
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
                if self.seconds == 0 {
                    self.resendShow = true
                }
            }
        }
    }
}

struct VerifyView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyView(phone: "050 000 000", showSmsVerify: .constant(true))
    }
}

struct PasscodeField_Previews: PreviewProvider {
    static var previews: some View {
        PasscodeField { (text, boolean ) in
            print(text)
        }
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
           .accentColor(.clear)
           .foregroundColor(.clear)
           .keyboardType(.numberPad)
      
//             .introspectTextField { textField in
//                 textField.tintColor = .clear
//                 textField.textColor = .clear
//                 textField.keyboardType = .numberPad
//                 textField.becomeFirstResponder()
//                 textField.isEnabled = !self.isDisabled
//         }
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

extension String {
    
    var digits: [Int] {
        var result = [Int]()
        
        for char in self {
            if let number = Int(String(char)) {
                result.append(number)
            }
        }
        
        return result
    }
    
}

extension Int {
    
    var numberString: String {
        
        guard self < 10 else { return "0" }
        
        return String(self)
    }
}
