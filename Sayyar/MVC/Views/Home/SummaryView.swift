//
//  SummaryView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 24/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct SummaryView: View {
    
    @State var isSearching : Bool = false
    
    @Binding var paymentMethod : Method
    
    @Binding var showPaymentType : Bool
    
    @State var pickupText : String
    @State var destinationText : String
    
    var body: some View {
        VStack(spacing: 0) {
            if isSearching {
                Color(#colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 0.45))
            } else {
                Spacer()
            }
            
            HStack(alignment: .top) {
                Spacer()
                Text("Searching for partner offer")
                    .font(.custom("Cairo-SemiBold", size: 15))
                    .foregroundColor(.white)
                .padding(.bottom, 20)
                Spacer()
            }
            .frame(height: 50)
            .background(RoundedCorners(color: purple, tl: 20, tr: 20, bl: 0, br: 0))
            .padding(.bottom,isSearching ? -20 : -50)
            
            VStack(spacing: 5) {
                
                
                HStack(spacing: 15) {
                    Image("destination").padding(.bottom, 15)
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment : .leading, spacing: -5) {
                            Text("from.destination".localized)
                                .font(.custom("Cairo-SemiBold", size: 18))
                            Text(pickupText)
                                .font(.custom("Cairo-SemiBold", size: 17))
                                .foregroundColor(Color(#colorLiteral(red: 0.7176470588, green: 0.7058823529, blue: 0.7058823529, alpha: 1)))
                        }
                        
                        VStack(alignment: .leading, spacing: -5) {
                            Text("to.destination".localized)
                                .font(.custom("Cairo-SemiBold", size: 18))
                            Text(destinationText)
                                .font(.custom("Cairo-SemiBold", size: 17))
                                .foregroundColor(Color(#colorLiteral(red: 0.7176470588, green: 0.7058823529, blue: 0.7058823529, alpha: 1)))
                        }
                    }
                    .foregroundColor(blktxt)
                    
                    
                    Spacer()
                }
                Divider()
                if !isSearching {
                    HStack {
                        HStack {
                            if paymentMethod.type == .cash {
                                Image("cash-pay")
                                    .resizable()
                                    .frame(width: 21, height: 12)
                                Text("Cash")
                                    .font(.custom("Cairo-Regular", size: 13))
                            } else {
                                Image("visa")
                                    .resizable()
                                    .frame(width: 21, height: 12)
                                Text("Credit Card")
                                    .font(.custom("Cairo-Regular", size: 13))
                                    .foregroundColor(blktxt)
                            }
                            
                            Image(systemName: "chevron.down").resizable().frame(width: 9, height: 5)
                                .foregroundColor(Color.black)
                        }.onTapGesture {
                            self.showPaymentType.toggle()
                        }
                        
                        Spacer()
                    }
                }
                
                
                if !isSearching {
                    HStack(alignment: .center, spacing: 10) {
                    // MARK: Add Pin
                    Button(action: {
                        withAnimation {
                            self.isSearching = true
                        }
                        
                    }) {
                        HStack(alignment: .center) {
                            Spacer()
                            Text("Confirm")
                                .font(.custom("Cairo-SemiBold", size: 20) )
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                    }.frame(height: 22, alignment: .center)
                        .padding(10)
                        .background(purple)
                        .cornerRadius(10)
                    }
                } else {
                    NavigationLink(destination: OfferView()) {
                        Text("Cancel")
                        .font(.custom("Cairo-SemiBold", size: 16))
                        .foregroundColor(.red)
                    }.padding(.vertical, -5)
                    
                }
            }
            .padding()
            .background(RoundedCorners(color: bgColor, tl: 20, tr: 20, bl: 0, br: 0))
            
        }
        .padding(.horizontal, isSearching ? 0 : 15)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        
        let supportedLocales: [Locale] = [
            "en",
            "ar",
            ].map(Locale.init(identifier:))
        
        return ForEach(supportedLocales, id: \.identifier) { locale in
            
            ForEach([ColorScheme.dark, .light], id: \.self) { scheme in
                SummaryView(paymentMethod: .constant(.init(type: .visa)), showPaymentType: .constant(true), pickupText: "Azizyah rd", destinationText: "King Faisal Rd")
                .previewLayout(.sizeThatFits)
                .background(Color.gray)
                .padding()
                .background(gray.edgesIgnoringSafeArea(.all))
                .environment(\.locale, locale)
                .previewDisplayName(Locale.current.localizedString(forIdentifier: locale.identifier)! + " \(scheme)")
                .colorScheme(scheme)
                
            }
        }
        
    }
}
