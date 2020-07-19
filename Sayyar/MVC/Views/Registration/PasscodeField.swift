//
//  PasscodeField.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 19/07/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI
import Introspect

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
