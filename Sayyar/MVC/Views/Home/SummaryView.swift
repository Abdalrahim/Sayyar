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
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
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
                            Text("Azizyah rd")
                                .font(.custom("Cairo-SemiBold", size: 17))
                                .foregroundColor(Color(#colorLiteral(red: 0.7176470588, green: 0.7058823529, blue: 0.7058823529, alpha: 1)))
                        }
                        
                        VStack(alignment: .leading, spacing: -5) {
                            Text("to.destination".localized)
                                .font(.custom("Cairo-SemiBold", size: 18))
                            Text("Azizyah rd")
                                .font(.custom("Cairo-SemiBold", size: 17))
                                .foregroundColor(Color(#colorLiteral(red: 0.7176470588, green: 0.7058823529, blue: 0.7058823529, alpha: 1)))
                        }
                    }
                    
                    
                    Spacer()
                }
                Divider()
                if !isSearching {
                    HStack {
                        Image("cash-pay").resizable().frame(width: 21, height: 12)
                        Text("Cash").font(.custom("Cairo-Regular", size: 13))
                        Image(systemName: "chevron.down").resizable().frame(width: 9, height: 5)
                            .foregroundColor(Color.black)
                        Spacer()
                    }
                }
                
                
                if !isSearching {
                    HStack(alignment: .center, spacing: 10) {
                    // MARK: Add Pin
                    Button(action: {
                        withAnimation {
                            self.isSearching.toggle()
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
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView().previewLayout(.sizeThatFits)
            .background(Color.gray)
    }
}
