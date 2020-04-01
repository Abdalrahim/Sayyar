//
//  SummaryView.swift
//  Sayyar
//
//  Created by Abdalrahim Abdullah on 24/03/2020.
//  Copyright © 2020 Teracit. All rights reserved.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image("destination").padding(.bottom, 17)
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment : .leading, spacing: -5) {
                        Text("from.destination")
                            .font(.custom("Cairo-SemiBold", size: 18))
                        Text("Azizyah rd")
                            .font(.custom("Cairo-SemiBold", size: 17))
                            .foregroundColor(Color(#colorLiteral(red: 0.7176470588, green: 0.7058823529, blue: 0.7058823529, alpha: 1)))
                    }
                    
                    VStack(alignment: .leading, spacing: -5) {
                        Text("to.destination")
                            .font(.custom("Cairo-SemiBold", size: 18))
                        Text("Azizyah rd")
                            .font(.custom("Cairo-SemiBold", size: 17))
                            .foregroundColor(Color(#colorLiteral(red: 0.7176470588, green: 0.7058823529, blue: 0.7058823529, alpha: 1)))
                    }
                }
                
                
                Spacer()
            }
            Divider()
            HStack {
                Image("cash-pay").resizable().frame(width: 21, height: 12)
                Text("Cash").font(.custom("Cairo-Regular", size: 13))
                Image(systemName: "chevron.down").resizable().frame(width: 9, height: 5)
                    .foregroundColor(Color.black)
                Spacer()
            }
            
            HStack(alignment: .center, spacing: 10) {
                // MARK: Add Pin
                Button(action: {
                    
                }) {
                    HStack(alignment: .center) {
                        Spacer()
                        Text("Confirm")
                            .font(.custom("Cairo-SemiBold", size: 20) )
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                }.frame(height: 22, alignment: .center)
                    .padding()
                    .background(purple)
                    .cornerRadius(10)
            }
        }.padding()
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView().previewLayout(.fixed(width: 500, height: 300))
    }
}
